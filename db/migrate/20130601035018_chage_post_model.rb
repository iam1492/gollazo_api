class ChagePostModel < ActiveRecord::Migration
  def up
  	remove_attachment :posts, :photo1
    remove_attachment :posts, :photo2
    remove_attachment :posts, :photo3
    remove_attachment :posts, :photo4

  	remove_column :posts, :item_description_1
  	remove_column :posts, :item_description_2
  	remove_column :posts, :item_description_3
  	remove_column :posts, :item_description_4

	remove_column :posts, :rank 
  end

  def down
  	add_attachment :posts, :photo1
    add_attachment :posts, :photo2
    add_attachment :posts, :photo3
    add_attachment :posts, :photo4

    add_column :posts, :item_description_1, :string, :default => ""
  	add_column :posts, :item_description_2, :string, :default => ""
  	add_column :posts, :item_description_3, :string, :default => ""
  	add_column :posts, :item_description_4, :string, :default => ""

	add_column :posts, :rank, :string, :default => ""  	
  end
end
