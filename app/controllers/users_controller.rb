class UsersController < ApiController

	def create
  	@user = User.new(params[:user])

    if @user.save
      metadata = {:success => true, :message=>"success to create user."}
      respond_with(@user, :api_template => :render_user, :root => :user, :meta => metadata)
      return
    else
      metadata = {:success => false, :message=>"fail to create user."}
      respond_with(@user, :api_template => :render_user, :root => :user, :meta => metadata)
      return  		
    end
  end

  def getUserInfo

  	@id = params[:id]
  	@user = User.find(@id)

  	if (@user.nil?)
      render :json=>{:success => false, :message=>"fail to get user."}
  	else
      metadata = {:success => true, :message=>"success to get user."}
      respond_with(@user, :api_template => :render_user, :root => :user, :meta => metadata)
  	end
  end
end
