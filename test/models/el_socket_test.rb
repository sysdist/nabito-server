# == Schema Information
#
# Table name: el_sockets
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  code          :string
#  url           :string
#  address       :string
#  gps_lat       :float
#  gps_lng       :float
#  voltage       :integer
#  i_limit       :integer
#  price_per_kWh :float
#  current_user  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  frequency     :integer
#  mqtt_id       :string
#  status        :integer
#

require 'test_helper'

class ElSocketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
