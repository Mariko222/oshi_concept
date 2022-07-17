class ChangeColumnsAddNotnullOnPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :url, :string, null: false
  end
end
