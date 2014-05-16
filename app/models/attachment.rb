class Attachment < ActiveRecord::Base
	
	has_attached_file :file, 
                    :styles => { :original => "800x", :thumb => "300x300>" }, 
                    :default_url => ""
    do_not_validate_attachment_file_type :file

	def file_path
		if (self.file.nil?)
			return nil
		end
		self.file.url
	end

	def file_thumb_path
		if (self.file.nil?)
			return nil
		end
		self.file.url(:thumb)  	
	end
end
