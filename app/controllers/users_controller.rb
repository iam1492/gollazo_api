class UsersController < ApiController

  def loggin
    user = User.find_by_fb_id(:fb_id)
    if (user)
      session[:user_id] = user.id
      render :json=>{:success => true, :message=>"success to loggin"}
    else
      render :json=>{:success => false, :message=>"fail to loggin"}
    end
  end

	def create
  	@user = User.new(params[:user])

    if @user.save
      render :json=>{:success => true, :message=>"success to create"}
      return
    else
      render :json=>{:success => false, :message=>"fail to create"}
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

  def getUserList
    @users = User.all
    if (@users.nil?)
      render :json=>{:success => false, :message=>"fail to get user."}
    else
      metadata = {:success => true, :message=>"success to get user."}
      respond_with(@users, :api_template => :render_user, :root => :user, :meta => metadata)
    end
  end

  def destroy
    session[:user_id] = nil
  end
end
