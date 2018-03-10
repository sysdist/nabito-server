class AddNew3FValsToSocketLoad < ActiveRecord::Migration[5.0]
  def change
    add_column :socket_loads, :I1, :float
    add_column :socket_loads, :V1, :float
    add_column :socket_loads, :P1, :float
    add_column :socket_loads, :I2, :float
    add_column :socket_loads, :V2, :float
    add_column :socket_loads, :P2, :float
    add_column :socket_loads, :I3, :float
    add_column :socket_loads, :V3, :float
    add_column :socket_loads, :P3, :float
    add_column :socket_loads, :I_total, :float
    add_column :socket_loads, :V_avg, :float
    add_column :socket_loads, :P_total, :float
  end
end
