class ChageSeletionToString < ActiveRecord::Migration
  def up
  	remove_column :selections, :selected_item
  	add_column :selections, :selected_items, :string, :default => ""
  end

  def down
  	add_column :selections, :selected_item, :integer, :default => -1
  	remove_column :selections, :selected_items
  end
end
