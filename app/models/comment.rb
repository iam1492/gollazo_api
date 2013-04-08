class Comment < ActiveRecord::Base
  attr_accessible :imei, :content, :post_id, :selected_num, :user_id
  belongs_to :post

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
    logger.debug @user
    if (@user.nil?)
      @user = User.getUserInfo(self.imei);
    end
    
    if (@user.nil?)
      return ""
    end

    @user.profile_thumbnail_url
  end

  def as_json options=nil
    options ||= {}
    options[:methods] = ((options[:methods] || []) + 
           [:name, :profile_thumbnail_url])
    super options
  end
end
