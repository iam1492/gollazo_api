class Comment < ActiveRecord::Base
  attr_accessible :content, :post_id, :selected_num, :user_id
  belongs_to :post

end
