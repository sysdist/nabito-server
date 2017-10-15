namespace :nabito do
  desc "Starting background process for MQTT monitoring"
  task :monitor_start => :environment do
    system "nohup ruby lib/tasks/monitor.rb > log/monitor.log &"  
    puts "Monitoring is running"
  end
  
  desc "Stop backgroud process for MQTT monitoring"
  task :monitor_stop => :environment do
    system 'pkill -f "ruby lib/tasks/monitor.rb"'
  end
end


#TODO:not used atm
# task :MW do
  # f = Rails.root.join('public/maintenance.html').to_s
  # bak = f + ".bak"
#   
  # if File.exist?(f) 
    # puts "Setting up MW"
    # File.rename(f, bak)
  # elsif File.exist?(bak) 
    # puts "Disabling MW"
    # File.rename(bak, f)
  # end 
# end
# 
# task :clear_master_data => :environment do
  # [ ElSocket, Relay, SocketMonitor ].each do |m|
    # puts "Truncating table #{m.table_name}"
    # ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{m.table_name} RESTART IDENTITY CASCADE;")
    # puts "Table #{m.table_name} truncated."
  # end
# end
# 
# task :clear_user_data => :environment do
  # [ User, SocketLoad, SocketUsage  ].each do |m|
    # puts "Truncating table #{m.table_name}"
    # ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{m.table_name} RESTART IDENTITY CASCADE;")
    # puts "Table #{m.table_name} truncated."
  # end
# end


# task :assign_currencies => :environment do
  # Country.all.each do |c|
    # puts "coutry: #{c.code} curr: #{c.currency_code}"
    # ccode = c.currency_code
    # curr = Currency.find_by_code(ccode)
      # #c.update_column(:currency_id, nil)
    # if curr
     # puts "Curr: #{curr.code} rate: #{curr.rate}"
      # c.update_column(:currency_id, curr.id)
    # end
  # end
# end

