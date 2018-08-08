class RemoveMqttIdFromElSocket < ActiveRecord::Migration[5.0]
  def change
    remove_column :el_sockets, :mqtt_id, :string
    add_column :el_sockets, :thing_name, :string
  end
end
