class AddBombToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :isBombed, :boolean, :default => false
  end
end
