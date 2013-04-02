class Post < ActiveRecord::Base
  attr_accessible :category_code, :description, :title,
  				  :vote_count_1, :vote_count_2, :vote_count_3, :vote_count_4, 
  				  :rank,
  				  :photo1, :photo2, :photo3, :photo4,
  				  :user_id
  acts_as_api		  
  self.per_page = 20

  has_attached_file :photo1, :styles => { :medium => "720x", :thumb => "100x100>" }, :default_url => ""
  has_attached_file :photo2, :styles => { :medium => "720x", :thumb => "100x100>" }, :default_url => ""
  has_attached_file :photo3, :styles => { :medium => "720x", :thumb => "100x100>" }, :default_url => ""
  has_attached_file :photo4, :styles => { :medium => "720x", :thumb => "100x100>" }, :default_url => ""
	
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :user_id, presence: true

  api_accessible :render_post do |t| 
  	t.add :id
  	t.add :category_code
  	t.add :description
  	t.add :title
    t.add :vote_count_1
    t.add :vote_count_2
    t.add :vote_count_3
    t.add :vote_count_4
    t.add :rank
    t.add :photo1
    t.add :photo2
    t.add :photo3
    t.add :photo4
    t.add :total_comments
    t.add :comments
  end

  api_accessible :render_post_list do |t| 
  	t.add :id
  	t.add :category_code
  	t.add :description
  	t.add :title
    t.add :vote_count_1
    t.add :vote_count_2
    t.add :vote_count_3
    t.add :vote_count_4
    t.add :rank
    t.add :photo1_thumb_path
    t.add :photo2_thumb_path
    t.add :photo3_thumb_path
    t.add :photo4_thumb_path
    t.add :total_comments
  end

  def total_comments
    self.comments.count
  end

  def photo1_path
  	if (self.photo1.nil?)
  		return nil
  	end
  	self.photo1.url
  end

  def photo1_medium_path
  	if (self.photo1.nil?)
  		return nil
  	end
  	self.photo1.url(:medium)  	
  end

  def photo1_thumb_path
  	if (self.photo1.nil?)
  		return nil
  	end
  	self.photo1.url(:thumb)  	
  end

  def photo2_path
  	if (self.photo2.nil?)
  		return nil
  	end
  	self.photo2.url
  end

  def photo2_medium_path
  	if (self.photo2.nil?)
  		return nil
  	end
  	self.photo2.url(:medium)  	
  end

  def photo2_thumb_path
  	if (self.photo2.nil?)
  		return nil
  	end
  	self.photo2.url(:thumb)  	
  end

  def photo3_path
  	if (self.photo3.nil?)
  		return nil
  	end
  	self.photo3.url
  end

  def photo3_medium_path
  	if (self.photo3.nil?)
  		return nil
  	end
  	self.photo3.url(:medium)  	
  end

  def photo3_thumb_path
  	if (self.photo3.nil?)
  		return nil
  	end
  	self.photo3.url(:thumb)  	
  end

  def photo4_path
  	if (self.photo4.nil?)
  		return nil
  	end
  	self.photo4.url
  end

  def photo4_medium_path
  	if (self.photo4.nil?)
  		return nil
  	end
  	self.photo4.url(:medium)  	
  end

  def photo4_thumb_path
  	if (self.photo4.nil?)
  		return nil
  	end
  	self.photo4.url(:thumb)  	
  end
end
