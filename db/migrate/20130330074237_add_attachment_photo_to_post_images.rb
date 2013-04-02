class AddAttachmentPhotoToPostImages < ActiveRecord::Migration
  def self.up
    change_table :post_images do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :post_images, :photo
  end
end
