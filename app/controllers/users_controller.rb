class UsersController < ApiController

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

  def destroy
    @user = User.getUserInfo(params[:imei])
    if @user.destroy
      render :json=>{:success => true, :message=>"success to destroy user."}
      return
    else
      render :json=>{:success => false, :message=>"fail to destroy user."}
      return      
    end
  end

  def devModifyIMEI
    @user = User.getUserInfo(params[:imei])
    new_imei = params[:new_imei]

    if (!@user.nil?)
      if (@user.update_attributes(:imei => new_imei))
        render :json=>{:success => true, :message=>"success"}
      else
        render :json=>{:success => false, :message=>"fail to update"}
      end
    else
      render :json=>{:success => false, :message=>"user is nil"}
    end
  end

  def updateNickname
    @imei = params[:imei]
    @new_nick_name = params[:nickname]

    @user = User.getUserInfo(@imei)
    
    if (@user.nil?)
      render :json=>{:success => false, :message=>"fail to change nickname. no user found"}
      return      
    end

    if (@user.update_attributes(:name => @new_nick_name))
      render :json=>{:success => true, :message=>"success to change nickname"}
      return
    else
      render :json=>{:success => false, :message=>"fail to change nickname"}
      return      
    end
  end

  def update
    @user = User.getUserInfo(params[:imei])
    @profile = params[:profile]
    @intro = params[:intro]
     
    if (@profile.nil?)
      @user.update_attributes(:intro => @intro) 
    else
      @user.update_attributes(:profile => @profile, :intro => @intro) 
    end

    if (@user.save)
      metadata = {:success => true, :message=>"success to get user."}
      render :json=>{:intro => @user.intro, :profile_thumbnail_url => @user.profile_thumbnail_url, :success => true, :result_code => 0, :message=>"success to update user."}
    else
      render :json=>{:success => false, :result_code => 2, :message=>"fail to update user."}
    end
  end

  def checkUniqueness
    @name = params[:name]
    if (User.uniqueName?(@name))
      render :json=>{:success => true, :message=>"success", :occupied=>false}
    else
      render :json=>{:success => true, :message=>"failed", :occupied=>true}
    end
  end

  def getUserInfo

  	@imei = params[:imei]
  	@user = User.getUserInfo(@imei)

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

end
