class CreateMygenres < ActiveRecord::Migration[6.1]
  def change
    create_table :mygenres do |t|
      t.references :user, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
    add_index :mygenres, [:user_id, :genre_id], unique: true
  end
end
