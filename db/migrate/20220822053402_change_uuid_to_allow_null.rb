class ChangeUuidToAllowNull < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :uuid, :string, null: true
  end

  def down
    change_column :users, :uuid, :string, null: false
  end
end
