class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :mypage_name, :integer
  end
end
