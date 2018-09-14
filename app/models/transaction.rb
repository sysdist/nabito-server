# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  debtor_id        :integer
#  creditor_id      :integer
#  box_id           :integer
#  connector_id     :integer
#  kWhs_used        :decimal(, )
#  price_per_kWh    :decimal(, )
#  amount           :decimal(, )
#  date_posted      :date
#  begin_time       :datetime
#  end_time         :datetime
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  meter_Whs_start  :integer
#  meter_Whs_finish :integer
#  tag_id_start     :integer
#  tag_id_finish    :integer
#

class Transaction < ApplicationRecord
  belongs_to :box
  belongs_to :connector
  
  def debtor
    User.find(debtor_id)
  end
  
  def creditor
    User.find(creditor_id)
  end
  
  def tag_start
    return nil unless tag_id_start
    Tag.find(tag_id_start)
  end
  
  def tag_finish
    return nil unless tag_id_finish
    Tag.find(tag_id_finish)
  end
  
  def start
    update(begin_time: Time.now.utc, status: "CHARGING_STARTED")
  end

  def finish
    total_kWhs = (meter_Whs_finish - meter_Whs_start).to_d / 1000
    a = total_kWhs * price_per_kWh
    update(kWhs_used: total_kWhs, amount: a, end_time: Time.now.utc, status: "CHARGING_FINISHED", date_posted: Date.today.to_s)
    
  end
  
  def aws_timestamp(tstamp)
    (tstamp.to_f * 1000).to_i.to_s
  end
  
  def aws_data_items
    client = AwsClient.dynamo_client
    
    resp = client.query({
      table_name: "device_data",
      key_condition_expression: "device_id = :a and #t between :begin and :end",
      expression_attribute_names: {
        "#t" => "timestamp",
      },
      expression_attribute_values: {
        ":a": connector.aws_conn_id, 
        ":begin": AwsClient.timestamp(begin_time),
        ":end":   AwsClient.timestamp(end_time),
        }, 
       
    })
    
    return resp.items
  end
    
  def energy_graph
    items = aws_data_items
    
    power_items = {}    
    items.each do |s|
      time = Time.at(s["timestamp"].to_i / 1000)
      power_items[time] = s["payload"]["meter_values"]["e"] - meter_Whs_start
    end
#     
    return power_items
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
  
  def current_graph
    items = aws_data_items
    
    current_items = {}    
    items.each do |s|
      time = Time.at(s["timestamp"].to_i / 1000)
      current_items[time] = s["payload"]["meter_values"]["i"]
    end

    return current_items
  end
  
end
