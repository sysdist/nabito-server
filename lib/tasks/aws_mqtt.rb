require 'mqtt'
require 'uri'
require 'json'


def receive_messages
  # Create a hash with the connection parameters
  
  conn_opts = {
      host: ENV['AWS_ENDPOINT_MQTT'] ,
      port: 8883,
      ssl: true,
      cert_file: ENV['NABITO_AWS_CERT_FILE'],
      key_file: ENV['NABITO_AWS_KEY_FILE'],
      ca_file: ENV['NABITO_AWS_CA_FILE']
  }

  client =  MQTT::Client.connect(conn_opts)
   
  client.subscribe('things/+/auth')
  client.get do |topic,message|
    puts "topic: #{topic}, msg: #{message}"
    auth_tag(topic, message)
  end

end

def auth_tag(topic, message)
  topic1 = topic.split('/')
  #TODO: connector_id = include in JSON message
  #socket_id = topic1[3]
  tag = parse_json(message)
  if tag 
    tag_nfc = tag["nfc"]
    
    if tag_nfc 
      #t = tag_string.gsub(/\s+/, "")
      site = ENV['NABITO_SITE']
      tag_string = tag_nfc["userid"]
      puts "curl -X POST -d \"tag_uid=#{tag_string}\" #{site}/en/connectors/1/token"
      
      system "curl -X POST -d \"tag_uid=#{tag_string}\" #{site}/en/connectors/1/token"  
    end  
  end
  
  
end

  
def parse_json(message)
    json = JSON.parse(message)
    return json
  rescue JSON::ParserError => e
    puts "invalid json"
    return nil
end

def shut_down
  puts "\nShutting down monitoring, #{Time.now}"
  sleep 1
end
 
# Trap ^C 
Signal.trap("INT") { 
  shut_down 
  exit
}

# Trap `Kill `
Signal.trap("TERM") {
    shut_down
    exit
  }
 
#main loop
puts "--Monitoring starting, #{Time.now}"
receive_messages



