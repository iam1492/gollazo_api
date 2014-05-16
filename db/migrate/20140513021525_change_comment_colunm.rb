class ChangeCommentColunm < ActiveRecord::Migration
  def change
  	rename_column :comments, :fb_id, :uid
  end
end
