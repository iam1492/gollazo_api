class AddUniquenessToImei < ActiveRecord::Migration
  def up
  	remove_index :users, :imei	
  	add_index :users, :imei, :unique => true
  end
  def down
  	add_index :users, :imei	
  	remove_index :users, :imei	
  end
end

