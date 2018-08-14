# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  debtor_id        :integer
#  creditor_id      :integer
#  box_id           :integer
#  connector_id     :integer
#  kWhs_used        :decimal(, )
#  price_per_kWh    :decimal(, )
#  amount           :decimal(, )
#  date_posted      :date
#  begin_time       :datetime
#  end_time         :datetime
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  meter_Whs_start  :integer
#  meter_Whs_finish :integer
#  tag_id_start     :integer
#  tag_id_finish    :integer
#

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
