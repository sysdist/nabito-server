# == Schema Information
#
# Table name: socket_loads
#
#  id           :integer          not null, primary key
#  el_socket_id :integer
#  time         :datetime
#  i1           :float
#  v1           :float
#  p1           :float
#  i2           :float
#  v2           :float
#  p2           :float
#  i3           :float
#  v3           :float
#  p3           :float
#  i_total      :float
#  v_avg        :float
#  p_total      :float
#

require 'test_helper'

class SocketLoadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
