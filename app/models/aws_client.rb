class AwsClient 
  
  def self.iot_client
    client = Aws::IoTDataPlane::Client.new( access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                            secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                            region: ENV['AWS_REGION'],
                                            endpoint: ENV['AWS_ENDPOINT'] )
                                  
    return client                                    
  end
  
  def self.dynamo_client
    client = Aws::DynamoDB::Client.new(
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )

    
    # client = Aws::DynamoDB::Client.new( access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                            # secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                            # region: ENV['AWS_REGION'],
                                            # endpoint: ENV['AWS_ENDPOINT'] )
#                                   
    return client                                    
  end
  
  def self.timestamp(tstamp)
    (tstamp.to_f * 1000).to_i.to_s
  end
  

  
end


  # def self.send_message(topic, message)
      # client = get_client()
      # client.connect()
      # client.publish(topic, message)
      # client.disconnect()
  # end

  

#aws_client = Aws::IoT::Client.new(
#  access_key_id: creds['access_key_id'],
#  secret_access_key: creds['secret_access_key']
#)

#resp = client.list_things()
#puts resp[0]
