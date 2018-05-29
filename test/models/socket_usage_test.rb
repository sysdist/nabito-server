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
#  start_tag    :string
#  end_tag      :string
#

require 'test_helper'

class SocketUsageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
