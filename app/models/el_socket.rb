# == Schema Information
#
# Table name: el_sockets
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  code          :string
#  url           :string
#  address       :string
#  gps_lat       :float
#  gps_lng       :float
#  voltage       :integer
#  i_limit       :integer
#  price_per_kWh :float
#  in_use        :boolean
#  current_user  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  frequency     :integer
#  mqtt_id       :string
#

class ElSocket < ApplicationRecord
  belongs_to :user
  
  enum status: { offline: 0, online: 1, active: 2, error: 3 }

  CLIENT_ID_LENGTH = 14 # number of characters in the clientID field,
                        # used in the new_client_id() function

  # require 'securerandom'
  # 2.4.0 :009 > SecureRandom.urlsafe_base64(15)
  # => "oYpoHYyzNvycqv5Mlvw8"
  # puts get_id(10)

  def switch_on(active_user, tag = nil)
    update(status: :active,current_user: active_user.id)
    mqtt_control_on
    socket_usage = SocketUsage.create!(user: active_user,
                                       el_socket: self, start_time: Time.now.utc,
                                       date: Date.today, start_tag: tag)

    active_user.last_usage = socket_usage.id
    active_user.save
  end

  def switch_off(active_user, tag = nil)
    mqtt_control_off
    socket_usage = SocketUsage.find(active_user.last_usage)

    socket_usage.end_tag = tag 
    socket_usage.end_time = Time.now.utc
    avg_watts = SocketLoad.where(time: socket_usage.start_time..socket_usage.end_time).average(:p_total)
    avg_watts = 0.0 if avg_watts == nil

    duration = socket_usage.end_time - socket_usage.start_time
    freq = 3600 / frequency

    kWh = avg_watts * duration / freq / 1000 / 3600

    socket_usage.kWhs = kWh
    socket_usage.amount = kWh * price_per_kWh
    socket_usage.save
    

    active_user.last_usage = nil
    active_user.save
    update(status: :online, current_user: nil)
  end

  def control_topic
    "user/#{user_id}/#{mqtt_id}/#{id}/control"
  end

  # def available?
    # !in_use
  # end
  
  
  
  # def status
    # if in_use
      # "IN USE"
    # else
      # "AVAILABLE"
    # end
  # end
  
  def in_use
    active?  
  end

  def new_client_id
    str = ''
    loop do
      str = SecureRandom.urlsafe_base64(CLIENT_ID_LENGTH - 4)
      break if str =~ /^[^-_]+$/
    end
    str.downcase
  end
  
  def current_graph
    if in_use 
      this_user = User.find(current_user)
      socket_usage = SocketUsage.find(this_user.last_usage)
      socket_usage.current_graph
    end
  end
    

  private

  def mqtt_control_on
    MqttClient.send_message(control_topic, 'ON')
  end

  def mqtt_control_off
    MqttClient.send_message(control_topic, 'OFF')
  end
end
