class ChangePostColunm < ActiveRecord::Migration
  def change
  	rename_column :posts, :fb_id, :uid
  end
end
