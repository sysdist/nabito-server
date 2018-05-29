class AddUidToTag < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :uid, :string
  end
end
