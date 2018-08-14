class AddCurrentTnxToConnector < ActiveRecord::Migration[5.0]
  def change
    add_column :connectors, :current_tnx, :integer
  end
end
