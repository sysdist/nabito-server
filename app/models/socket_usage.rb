# == Schema Information
#
# Table name: socket_usages
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  el_socket_id :integer
#  start_time   :datetime
#  end_time     :datetime
#  kWhs         :float
#  amount       :float
#  date         :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class SocketUsage < ApplicationRecord
  belongs_to :user
  belongs_to :el_socket


  def get_loads
    socket_loads = SocketLoad.where(time: start_time .. end_time)
    loads = {}
    socket_loads.each do |s|
      loads[s.time] = s.p_total
    end
    return loads
  end

  def current_graph
    socket_loads = SocketLoad.where(time: 2.hours.ago .. Time.now)
    loads = {}
    socket_loads.each do |s|
      loads[s.time] = s.p_total
    end
    return loads
  end

  
  
end
