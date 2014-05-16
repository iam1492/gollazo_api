class EditCommentTable < ActiveRecord::Migration
  def change
  	add_column :comments, :fb_id, :string
  end
end
