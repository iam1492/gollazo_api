class RemoveSomeColoumFromUser < ActiveRecord::Migration
  def up
  	remove_index :users, :fb_id
	remove_index :users, :access_token
  	remove_column :users, :fb_id
  	remove_column :users, :access_token
  	remove_column :users, :gender
	remove_column :users, :first_name
	remove_column :users, :last_name
	add_column :users, :imei, :string, :default => ""
  	add_index :users, :imei
  end

  def down
  	add_column :users, :fb_id, :string, :null => false
    add_column :users, :access_token, :string, :default => ""
    add_column :users, :gender, :string, :default => ""
    add_column :users, :first_name, :string, :default => ""
    add_column :users, :last_name, :string, :default => ""
    add_index :users, :fb_id, :unique => true
    add_index :users, :access_token

	remove_index :users, :imei	
    remove_column :users, :imei
    
  end
end
