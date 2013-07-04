class User < ActiveRecord::Base
  attr_accessor   :selection
  attr_accessible :imei, :name, :profile, :intro, :selection
  has_attached_file :profile, :styles => { :original => "720x", :medium => "200x200>", :thumb => "100x100>" }

  after_save    :expire_user_cache
  after_destroy :expire_user_cache

  acts_as_api
  acts_as_voter
  
  has_many :selections
  has_many :posts, :through => :selections

  api_accessible :render_user do |t|
    t.add :id
    t.add :imei
  	t.add :name
  	t.add :profile_thumbnail_url
    t.add :profile_url
    t.add :intro
  end

  api_accessible :render_user_with_selection do |t|
    t.add :id
    t.add :imei
    t.add :name
    t.add :profile_thumbnail_url
    t.add :profile_url
    t.add :intro
    t.add :selection
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

  def self.getUserInfo(_imei)
    where("imei = ?", _imei).first
  end

  def self.cachedUserInfo(_imei)
    Rails.cache.fetch("userinfo-#{_imei}") do
      User.getUserInfo(_imei)
    end
  end

  def expire_user_cache
    Rails.cache.delete("userinfo-#{self.imei}")
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
