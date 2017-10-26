class FixTypeColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :tags, :type, :tag_type
  end
end
