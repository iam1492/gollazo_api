class ChangeUserColunm < ActiveRecord::Migration
  def change
    rename_column :users, :fb_id, :uid
    rename_column :users, :fb_access_token, :access_token
  end
end
