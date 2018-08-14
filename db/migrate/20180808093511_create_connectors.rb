class CreateConnectors < ActiveRecord::Migration[5.0]
  def change
    create_table :connectors do |t|
      t.references :box, foreign_key: true
      t.string :aws_conn_id
      t.string :code
      t.string :url
      t.decimal :power
      t.integer :voltage
      t.decimal :i_max
      t.decimal :price_per_kWh
      t.integer :current_user
      t.integer :frequency
      t.string :status

      t.timestamps
    end
  end
end
