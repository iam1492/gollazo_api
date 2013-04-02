class RemoveUrlsFromPost < ActiveRecord::Migration
  def change
  	remove_column :posts, :url_1
  	remove_column :posts, :url_2
  	remove_column :posts, :url_3
  	remove_column :posts, :url_4
  end
end
