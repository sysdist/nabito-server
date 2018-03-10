class RemoveUpperCaseComumnsFromSocketLoad < ActiveRecord::Migration[5.0]
  def change
    remove_column :socket_loads, :I1, :string
    remove_column :socket_loads, :V1, :string
    remove_column :socket_loads, :P1, :string
    remove_column :socket_loads, :I2, :string
    remove_column :socket_loads, :V2, :string
    remove_column :socket_loads, :P2, :string
    remove_column :socket_loads, :I3, :string
    remove_column :socket_loads, :V3, :string
    remove_column :socket_loads, :P3, :string
    remove_column :socket_loads, :I_total, :string
    remove_column :socket_loads, :V_avg, :string
    remove_column :socket_loads, :P_total, :string
  end
end
