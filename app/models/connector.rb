# == Schema Information
#
# Table name: connectors
#
#  id            :integer          not null, primary key
#  box_id        :integer
#  aws_conn_id   :string
#  code          :string
#  url           :string
#  power         :decimal(, )
#  voltage       :integer
#  i_max         :decimal(, )
#  price_per_kWh :decimal(, )
#  current_user  :integer
#  frequency     :integer
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  name          :string
#  current_tnx   :integer
#

class Connector < ApplicationRecord
  belongs_to :box
  
  enum status: { offline: "OFFLINE", online: "ONLINE", active: "ACTIVE", error: "ERROR" }
  
  def in_use
    active?  
  end
  
  def last_power
    client = AwsClient.dynamo_client
    
    resp = client.query({
      table_name: "device_data",
      key_condition_expression: "device_id = :a and #t between :begin and :end",
      expression_attribute_names: {
        "#t" => "timestamp",
      },
      expression_attribute_values: {
        ":a": aws_conn_id, 
        ":begin": AwsClient.timestamp(10.minutes.ago),
        ":end":   AwsClient.timestamp(Time.now),
        }, 
       
    })
    
    items = resp.items
    last_item = resp.items.last
    return last_item["payload"]["meter_values"]["p"]
    
  end

  
  def current_graph
    client = AwsClient.dynamo_client
    
    resp = client.query({
      table_name: "device_data",
      key_condition_expression: "device_id = :a and #t between :begin and :end",
      expression_attribute_names: {
        "#t" => "timestamp",
      },
      expression_attribute_values: {
        ":a": aws_conn_id, 
        ":begin": AwsClient.timestamp(1.hour.ago),
        ":end":   AwsClient.timestamp(Time.now),
        }, 
       
    })
    
    items = resp.items
    
    energy_items = {}    
    items.each do |s|
      time = Time.at(s["timestamp"].to_i / 1000)
      energy_items[time] = s["payload"]["meter_values"]["p"]
    end

    return energy_items
    
  end
  
  def power_graph
    items = aws_data_items
    
    energy_items = {}    
    items.each do |s|
      time = Time.at(s["timestamp"].to_i / 1000)
      energy_items[time] = s["payload"]["meter_values"]["p"]
    end

    return energy_items
  end
  
  def payload_string(turn_on)
      payload = { state: { desired: { connectors: {} } } }
      payload[:state][:desired][:connectors][name] =  {on: turn_on}
      return JSON[payload]
  end
  
  def shadow_switch(iot_client, turn_on)
      resp = iot_client.update_thing_shadow({
        thing_name: box.aws_thing_name, # required
        payload: payload_string(turn_on)
      })      
  end
  
  
  def switch_on(active_user, tag_id = nil)
      client = AwsClient.iot_client
      
      values = meter_values(client)
      
      tnx = Transaction.create(debtor_id: active_user.id, creditor_id: box.user.id, box_id: box.id,
                               connector_id: self.id, price_per_kWh: price_per_kWh, meter_Whs_start: values["e"], tag_id_start: tag_id)
      tnx.start()
      update(status: :active,current_user: active_user.id, current_tnx: tnx.id)
      
      
      client = AwsClient.iot_client
      shadow_switch(client, true)

  end

  def switch_off(active_user, tag_id = nil)
      client = AwsClient.iot_client
      tnx = Transaction.find(current_tnx)
      values = meter_values(client)
      tnx.meter_Whs_finish = values["e"]
      tnx.tag_id_finish = tag_id
      tnx.save
      tnx.finish

      shadow_switch(client, false)
      
      update(status: :online ,current_user: nil, current_tnx: nil)
  end
  
  def meter_values(iot_client)
      shadow = iot_client.get_thing_shadow({
        thing_name: box.aws_thing_name
      })
      o = JSON[shadow.payload.string]
      meter_values = o["state"]["reported"]["connectors"][name]["meter_values"]
      return meter_values 
  end
  
  def test
      client = AwsClient.iot_client
      vals = meter_values(client) 
      
      puts vals
      puts vals["e"]
  end
  
end
