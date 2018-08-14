class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :debtor_id
      t.integer :creditor_id
      t.references :box, foreign_key: true
      t.references :connector, foreign_key: true
      t.decimal :kWhs_used
      t.decimal :price_per_kWh
      t.decimal :amount
      t.date :date_posted
      t.timestamp :begin_time
      t.timestamp :end_time
      t.string :status

      t.timestamps
    end
  end
end
