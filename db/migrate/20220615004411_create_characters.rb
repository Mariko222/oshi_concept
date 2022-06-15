class CreateCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
    add_index :characters, [:genre_id, :name], unique: true
  end
end
