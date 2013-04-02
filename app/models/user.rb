class User < ActiveRecord::Base
  attr_accessible :fb_id, :first_name, :gender,
   :last_name, :name, :profile_thumbnail_url, :profile_url
  
  acts_as_api

  has_many :posts, dependent: :destroy

  api_accessible :render_user do |t|
    t.add :id
    t.add :fb_id
  	t.add :first_name
  	t.add :last_name
  	t.add :name
    t.add :gender
  	t.add :profile_thumbnail_url
    t.add :profile_url
  end
end
