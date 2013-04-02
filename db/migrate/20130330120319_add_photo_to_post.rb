class AddPhotoToPost < ActiveRecord::Migration
  def self.up
    add_attachment :posts, :photo1
    add_attachment :posts, :photo2
    add_attachment :posts, :photo3
    add_attachment :posts, :photo4
  end

  def self.down
    remove_attachment :posts, :photo1
    remove_attachment :posts, :photo2
    remove_attachment :posts, :photo3
    remove_attachment :posts, :photo4
  end
end
