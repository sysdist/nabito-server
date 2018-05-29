class RemoveUserRefFromTag < ActiveRecord::Migration[5.0]
  def change
    remove_column :tags, :user_ref, :string
  end
end
