class RemoveTextFromPosts < ActiveRecord::Migration[6.1]
  def up
    remove_column :posts, :text
  end

  def down
    add_column :posts, :text, :text
  end
end
