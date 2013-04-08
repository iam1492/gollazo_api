class AddItemCountToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :item_count, :integer, :default => 0
  end
end
