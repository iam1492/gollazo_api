class Post < ActiveRecord::Base
  attr_accessible :category_code, :description, :title,
  				  :vote_count_1, :vote_count_2, :vote_count_3, :vote_count_4, 
  				  :rank,
            :imei,
            :isBombed

  acts_as_api		  
  acts_as_votable

  self.per_page = 20
	
  has_many :items, dependent: :destroy, :order => "id ASC"
  has_many :comments, dependent: :destroy, :order => "created_at ASC"
  has_many :selections, dependent: :destroy
  has_many :users, :through => :selections

  api_accessible :render_post do |t| 
  	t.add :id
  	t.add :category_code
  	t.add :description
  	t.add :title
    t.add :total_comments
    t.add :comments
    t.add :profile_thumbnail_url
    t.add :name
    t.add :imei
    t.add :items, :template => :render_item
    t.add :isBombed
    t.add :item_count
    t.add :total_vote
    t.add :created_at
  end

  api_accessible :render_post_list do |t| 
  	t.add :id
  	t.add :category_code
  	t.add :description
  	t.add :title
    t.add :items, :template => :render_item
    t.add :total_comments
    t.add :profile_thumbnail_url
    t.add :name
    t.add :imei
    t.add :isBombed
    t.add :item_count
    t.add :total_vote
  end

  def getSelectedNum (user_id)

      @selection = Selection.where("post_id = ? and user_id = ?", self.id, user_id)
      if (@selection.length ==0 || @selection.nil?)
        return ""
      else
        if (@selection.first.selected_items.nil?)
          return ""
        else
          return @selection.first.selected_items
        end
      end
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

  def isMyPost?(_imei)
    if (self.imei.nil?)
      return false
    end

    if (_imei.eql? self.imei)
      return true
    else
      return false
    end
  end

  def total_vote
    count = 0
    self.items.each do |item| 
      count += item.upvote_count
    end
    count
  end

  def total_comments
    self.comments.count
  end

  def item_count
    self.items.count
  end
end
