class ChangeUsersMypageNameDatatype < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :mypage_name, :string
  end
end
