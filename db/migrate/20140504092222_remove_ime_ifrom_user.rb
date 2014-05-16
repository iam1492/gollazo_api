class RemoveImeIfromUser < ActiveRecord::Migration
  def change
  	remove_index :users, :imei	
  	remove_column :users, :imei
  end
end
