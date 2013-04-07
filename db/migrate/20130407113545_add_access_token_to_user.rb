class AddAccessTokenToUser < ActiveRecord::Migration
  def change
  	add_column :users, :access_token, :string, :default => ""
  	add_index :users, :access_token
  end
end
