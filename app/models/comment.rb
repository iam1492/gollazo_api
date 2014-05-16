class Comment < ActiveRecord::Base
  # attr_accessible :id, :imei, :content, :post_id
  belongs_to :post

  def nickname
  	user = User.find_by_uid(self.uid)

    if (user.nil?)
      user = User.find_by_uid('999')      
    end
    
    if (user.nil?)
      return ""
    end

  	user.name
  end

  def selected_num
    @post = Post.find(self.post_id)
    user = User.find_by_uid(self.uid)

    if (user.nil?)
      user = User.find_by_uid('999')      
    end
    
    if (user.nil?)
      return ""
    end

    @selected_num = @post.getSelectedNum (user.id)
    @selected_num
  end

  def profile_thumbnail_url
    user = User.find_by_uid(self.uid)
    
    if (user.nil?)
      user = User.find_by_uid('999')      
    end

    if (user.nil?)
      return ""
    end

    user.profile_thumbnail_url
  end

  def as_json options=nil
    options ||= {}
    options[:methods] = ((options[:methods] || []) + 
           [:nickname, :profile_thumbnail_url, :selected_num])
    super options
  end
end
