# == Schema Information
#
# Table name: boxes
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  code           :string
#  type           :string
#  power          :decimal(, )
#  description    :string
#  url            :string
#  address        :string
#  gps_lat        :float
#  gps_lng        :float
#  status         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  aws_thing_name :string
#

require 'test_helper'

class BoxTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
