class MqttClient

  def self.get_client
    uri = URI.parse(ENV['NABITO_MQTT_URL'])
    client = MQTT::Client.connect(host: uri.hostname,
                                  port: uri.port, 
                                  username: uri.user,
                                  password: uri.password )
                                  
    return client                                    
  end
  
  def self.send_message(topic, message)
      client = get_client()
      client.connect()
      client.publish(topic, message)
      client.disconnect()
  end


end