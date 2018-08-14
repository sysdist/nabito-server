class CreateBoxes < ActiveRecord::Migration[5.0]
  def change
    create_table :boxes do |t|
      t.references :user, foreign_key: true
      t.string :code
      t.string :type
      t.decimal :power
      t.string :description
      t.string :url
      t.string :address
      t.float :gps_lat
      t.float :gps_lng
      t.string :status

      t.timestamps
    end
  end
end
