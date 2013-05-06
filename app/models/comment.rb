class Comment < ActiveRecord::Base
  attr_accessible :id, :imei, :content, :post_id, :selected_num
  belongs_to :post

  def nickname
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

  def selected_num
    @post = Post.find(self.post_id)
    @user = User.cachedUserInfo(self.imei)
    if (@user.nil?)
      @user = User.getUserInfo(self.imei);
    end
    
    if (@user.nil?)
      return -1
    end

    @selected_num = @post.getSelectedNum (@user.id)
    @selected_num
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
           [:nickname, :profile_thumbnail_url, :selected_num])
    super options
  end
end
