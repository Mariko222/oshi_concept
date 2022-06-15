class CreateMygenreFavoriteCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :mygenre_favorite_characters do |t|
      t.references :mygenre, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
    add_index :mygenre_favorite_characters, [:mygenre_id, :character_id], unique: true, name: 'mygenre_favorite_characters_index'
  end
end
