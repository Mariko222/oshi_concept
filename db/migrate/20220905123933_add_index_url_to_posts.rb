class AddIndexUrlToPosts < ActiveRecord::Migration[6.1]
  def change
    add_index :posts, [:url, :mygenre_id], unique: true
  end
end
