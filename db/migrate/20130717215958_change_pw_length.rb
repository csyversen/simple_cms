class ChangePwLength < ActiveRecord::Migration
  def up
    change_column("admin_users", "hashed_password", :string, :limit => 64)
  end

  def down
    change_column("admin_users", "hashed_password", :string, :limit => 40)
  end
end
