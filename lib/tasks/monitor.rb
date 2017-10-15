require 'pg'
require 'mqtt'
require 'uri'
  
  def pg_connect
    uri = URI.parse(ENV['NABITO_DATABASE_URL'])
    conn = PGconn.connect(host: uri.hostname, port: uri.port, user: uri.user, password: uri.password, dbname:  uri.path[1..-1])
    return conn
  end
  
  def receive_messages
    uri = URI.parse(ENV['NABITO_MQTT_URL'])
    client = MQTT::Client.connect(host: uri.hostname,
                                  port: uri.port, 
                                  username: uri.user,
                                  password: uri.password )
    
    # mqtt topic structure: user/user_id/mqtt_id/socket_id/load
    client.subscribe('user/+/+/+/+')
    client.get do |topic,message|
      puts "topic: #{topic}, msg: #{message}"
      t = topic.split('/')
      case t[4]
      when "load"
        log_socket_load(topic, message)
      when "status"
        socket_id = t[3]
        update_socket_status(socket_id, message)
      end
    end
  end
  
  def log_socket_load(topic, message)
    load = parse_load(message)
      if load then
        t = topic.split('/')
        socket_id = t[3]
        i = load["I"]
        v = load["V"]
        p = load["P"]
        create_socket_load(socket_id, i, v, p, Time.now)
      end
  end

  def parse_load(message)
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
  
  def create_socket_load(el_socket_id, i_current, voltage, power, time)
    conn = pg_connect()
    conn.prepare('statement1', 'insert into socket_loads (el_socket_id, i_current, voltage, power, time) values ($1, $2, $3, $4, $5)')
    conn.exec_prepared('statement1', [ el_socket_id, i_current, voltage, power, time ])
    conn.close
  end
  
  def update_socket_status(el_socket_id, status)
    # ElSocket::enum status: { offline: 0, online: 1, active: 2, error: 3 }
    value =
      case status
      when "OFFLINE" then 0
      when "ONLINE" then 1
      when "ACTIVE" then 2
      when "ERROR" then 3
      end   
    conn = pg_connect()
    conn.prepare('statement1','update el_sockets set status = $1 where id = $2')
    conn.exec_prepared('statement1', [ value, el_socket_id ])
    conn.close
  end
  
  #main loop
  puts "--Monitoring starting, #{Time.now}"
  receive_messages

  
  
