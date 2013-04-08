class AddImeiToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :imei, :string, :default => ""
  end
end
