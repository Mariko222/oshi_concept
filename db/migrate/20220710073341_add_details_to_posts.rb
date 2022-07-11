class AddDetailsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :title, :string
    add_column :posts, :text, :text
    add_column :posts, :image, :string
  end
end
