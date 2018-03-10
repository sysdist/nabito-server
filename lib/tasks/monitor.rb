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
      when "auth"
        auth_tag(topic, message)
      end
    end
  end
  
  def auth_tag(topic, message)
    topic1 = topic.split('/')
    socket_id = topic1[3]
    tag = parse_json(message)
    tag_string = tag["RFID"]["UID"]
    t = tag_string.gsub(/\s+/, "")
    site = ENV['NABITO_SITE']
    puts "curl -X POST -d \"tag=#{t}\" #{site}/en/el_sockets/#{socket_id}/rfid"
    system "curl -X POST -d \"tag=#{t}\" #{site}/en/el_sockets/#{socket_id}/rfid"

  end
    
  
  def log_socket_load(topic, message)
    load = parse_json(message)
      if load then
        t = topic.split('/')
        socket_id = t[3]
        i1 = load["I1"]
        v1 = load["V1"]
        p1 = load["P1"]
        i2 = load["I2"]
        v2 = load["V2"]
        p2 = load["P2"]
        i3 = load["I3"]
        v3 = load["V3"]
        p3 = load["P3"]
        i_total = load["I_Total"]
        v_avg = load["V_avg"] || v1
        p_total = load["P_Total"]
        t = load["timestamp"]
        create_socket_load(socket_id, i1, v1, p1, i2, v2, p2, i3, v3, p3, i_total, v_avg, p_total, t)
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
  
  def create_socket_load(el_socket_id, i1, v1, p1, i2, v2, p2, i3, v3, p3, i_total, v_avg, p_total, time)
    conn = pg_connect()
    conn.prepare('statement1', "insert into socket_loads (el_socket_id, i1, v1, p1, i2, v2, p2, i3, v3, p3, i_total, v_avg, p_total, time) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)")
    conn.exec_prepared('statement1', [ el_socket_id, i1, v1, p1, i2, v2, p2, i3, v3, p3, i_total, v_avg, p_total, time ])
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

  
  
