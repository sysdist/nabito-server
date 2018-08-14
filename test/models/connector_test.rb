# == Schema Information
#
# Table name: connectors
#
#  id            :integer          not null, primary key
#  box_id        :integer
#  aws_conn_id   :string
#  code          :string
#  url           :string
#  power         :decimal(, )
#  voltage       :integer
#  i_max         :decimal(, )
#  price_per_kWh :decimal(, )
#  current_user  :integer
#  frequency     :integer
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  name          :string
#  current_tnx   :integer
#

require 'test_helper'

class ConnectorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
