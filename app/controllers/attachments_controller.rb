class AttachmentsController < ApplicationController
  def create
  	file = Attachment.create(attachment_params)
  	if file.save
      render :json=>{:success => true, :message=>"success to upload image", :file_path => file.file_path}
      return
    else
      render :json=>{:success => false, :message=>"fail to upload image"}
      return  		
    end
  end

  private
  def attachment_params
  	params.permit(:file)
  end
end
