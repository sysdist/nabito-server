# == Schema Information
#
# Table name: socket_loads
#
#  id           :integer          not null, primary key
#  el_socket_id :integer
#  i_current    :float
#  voltage      :float
#  power        :float
#  time         :datetime
#

class SocketLoad < ApplicationRecord
  belongs_to :el_socket
end
