class AddAwsThingNameToBox < ActiveRecord::Migration[5.0]
  def change
    add_column :boxes, :aws_thing_name, :string
  end
end
