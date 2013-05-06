class RemoveSelectedNumFromComment < ActiveRecord::Migration
  def change
  	remove_column :comments, :selected_num
  end
end
