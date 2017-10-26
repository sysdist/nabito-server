class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.references :user, foreign_key: true
      t.string :type
      t.string :user_ref
      t.string :token
      t.string :pin
      t.string :status

      t.timestamps
    end
  end
end
