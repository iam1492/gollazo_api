class AddItemDescriptionToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :item_description_1, :string, :default => ""
  	add_column :posts, :item_description_2, :string, :default => ""
  	add_column :posts, :item_description_3, :string, :default => ""
  	add_column :posts, :item_description_4, :string, :default => ""
  end
end
