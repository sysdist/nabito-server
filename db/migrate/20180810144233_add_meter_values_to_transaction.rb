class AddMeterValuesToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :meter_Whs_start, :integer
    add_column :transactions, :meter_Whs_finish, :integer
  end
end
