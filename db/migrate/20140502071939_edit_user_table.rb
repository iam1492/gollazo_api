class EditUserTable < ActiveRecord::Migration
  def change
  	add_column :users, :fb_id, :string
    add_column :users, :fb_access_token, :string, :default => ""
    add_column :users, :email, :string, :default => ""
  end
end
