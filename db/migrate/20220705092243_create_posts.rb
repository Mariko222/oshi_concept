class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :category, default: 0, null: false
      t.integer :type, default: 0, null: false
      t.string :url
      t.references :mygenre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
