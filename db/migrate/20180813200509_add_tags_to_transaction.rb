class AddTagsToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :tag_id_start, :integer
    add_column :transactions, :tag_id_finish, :integer
  end
end
