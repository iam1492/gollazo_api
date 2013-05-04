class AddSelectionsTable < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :selected_item,            :default => -1
    end
    
  end
end
