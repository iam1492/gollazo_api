class User < ActiveRecord::Base
  attr_accessor   :selection
  # attr_accessible :imei, :name, :profile, :intro, :selection
  has_attached_file :profile, :styles => { :original => "720x", :medium => "200x200>", :thumb => "100x100>" }, :default_url => "/images/profile/missing.png"
  do_not_validate_attachment_file_type :profile
  acts_as_api
  acts_as_voter
  
  has_many :selections
  has_many :posts, :through => :selections

  api_accessible :render_user do |t|
    t.add :id
  	t.add :name
  	t.add :profile_thumbnail_url
    t.add :profile_url
    t.add :intro
    t.add :uid
    t.add :email
    t.add :access_token
  end

  api_accessible :render_user_with_selection do |t|
    t.add :id
    t.add :name
    t.add :profile_thumbnail_url
    t.add :profile_url
    t.add :intro
    t.add :uid
    t.add :email
    t.add :selection
    t.add :access_token
  end

  def profile_url
    if (self.profile.nil?)
      return nil
    end
    self.profile.url
  end

  def profile_thumbnail_url
    if (self.profile.nil?)
      return nil
    end
    self.profile.url(:thumb)
  end

  def self.uniqueName?(_name)
    name = where("name = ?", _name).first
    if (name.nil?)
      return true
    else
      return false
    end
  end
end
