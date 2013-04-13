class Post < ActiveRecord::Base
  attr_accessible :category_code, :description, :title,
  				  :vote_count_1, :vote_count_2, :vote_count_3, :vote_count_4, 
  				  :rank,
  				  :photo1, :photo2, :photo3, :photo4,
            :imei,
            :item_count,
            :item_description_1, :item_description_2, :item_description_3, :item_description_4

  acts_as_api		  
  acts_as_votable

  self.per_page = 20

  has_attached_file :photo1, :styles => { :original => "720x", :medium => "480x", :thumb => "100x100>" }, :default_url => ""
  has_attached_file :photo2, :styles => { :original => "720x", :medium => "480x", :thumb => "100x100>" }, :default_url => ""
  has_attached_file :photo3, :styles => { :original => "720x", :medium => "480x", :thumb => "100x100>" }, :default_url => ""
  has_attached_file :photo4, :styles => { :original => "720x", :medium => "480x", :thumb => "100x100>" }, :default_url => ""
	
  has_many :comments, dependent: :destroy, :order => "created_at ASC"

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
    t.add :photo1_path
    t.add :photo2_path
    t.add :photo3_path
    t.add :photo4_path
    t.add :total_comments
    t.add :comments
    t.add :has_voted
    t.add :profile_thumbnail_url
    t.add :name
    t.add :imei
    t.add :item_description_1
    t.add :item_description_2
    t.add :item_description_3
    t.add :item_description_4
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
    t.add :has_voted
    t.add :profile_thumbnail_url
    t.add :name
    t.add :imei
  end

  def name
    if (self.imei.nil?)
      return ""
    end
    
    @user = User.cachedUserInfo(self.imei)
    if (@user.nil?)
      @user = User.getUserInfo(self.imei);
    end
    
    if (@user.nil?)
      return ""
    end

    @user.name
  end

  def profile_thumbnail_url
    
    if (self.imei.nil?)
      return ""
    end
    
    @user = User.cachedUserInfo(self.imei)
    if (@user.nil?)
      @user = User.getUserInfo(self.imei);
    end
    
    if (@user.nil?)
      return ""
    end

    @user.profile_thumbnail_url
  end

  def has_voted
    if (self.imei.nil?)
      return ""
    end
    @user = User.cachedUserInfo(self.imei)
    if (@user.nil?)
      @user = User.getUserInfo(self.imei);
    end
    
    if (@user.nil?)
      return ""
    end
    @user.voted_up_on?(self)
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
