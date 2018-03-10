class AddTagsToSocketUsage < ActiveRecord::Migration[5.0]
  def change
    add_column :socket_usages, :start_tag, :string
    add_column :socket_usages, :end_tag, :string
  end
end
