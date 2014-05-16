class Item < ActiveRecord::Base
  # attr_accessible :description, :post_id, :score, :photo

  acts_as_api		  
  acts_as_votable

  has_attached_file :photo, 
                    :styles => { :original => "1080x", :medium => "480x", :thumb => "300x300>" }, 
                    :default_url => ""
  do_not_validate_attachment_file_type :photo
  # validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  belongs_to :post

  api_accessible :render_item do |t| 
  	t.add :id
    t.add :description
    t.add :photo_path
    t.add :photo_medium_path
    t.add :photo_thumb_path
    t.add :upvote_count
    t.add :downvote_count
  end

  def photo_path
  	if (self.photo.nil?)
  		return nil
  	end
  	self.photo.url
  end

  def photo_medium_path
  	if (self.photo.nil?)
  		return nil
  	end
  	self.photo.url(:medium)  	
  end

  def photo_thumb_path
  	if (self.photo.nil?)
  		return nil
  	end
  	self.photo.url(:thumb)  	
  end

  def up_vote (user)
    @success = self.vote :voter => user, :vote => 'like'
    if (@success)
      return true
    else
      return false
    end
  end

  def upvote_count
  	self.upvotes.size
  end

  def downvote_count
    self.downvotes.size
  end

end
