class AddLowerCaseValsToSocketLoad < ActiveRecord::Migration[5.0]
  def change
    add_column :socket_loads, :i1, :float
    add_column :socket_loads, :v1, :float
    add_column :socket_loads, :p1, :float
    add_column :socket_loads, :i2, :float
    add_column :socket_loads, :v2, :float
    add_column :socket_loads, :p2, :float
    add_column :socket_loads, :i3, :float
    add_column :socket_loads, :v3, :float
    add_column :socket_loads, :p3, :float
    add_column :socket_loads, :i_total, :float
    add_column :socket_loads, :v_avg, :float
    add_column :socket_loads, :p_total, :float
  end
end
