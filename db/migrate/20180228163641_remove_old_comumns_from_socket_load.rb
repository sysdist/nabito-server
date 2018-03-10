class RemoveOldComumnsFromSocketLoad < ActiveRecord::Migration[5.0]
  def change
    remove_column :socket_loads, :i_current, :string
    remove_column :socket_loads, :voltage, :string
    remove_column :socket_loads, :power, :string
  end
end
