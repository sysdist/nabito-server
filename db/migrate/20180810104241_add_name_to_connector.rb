class AddNameToConnector < ActiveRecord::Migration[5.0]
  def change
    add_column :connectors, :name, :string
  end
end
