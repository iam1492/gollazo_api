class UsersController < ApiController
  skip_before_filter  :verify_authenticity_token

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

  def registerGCM
    user = User.find_by_access_token(params[:access_token])
    device_id = params[:device_id]

    user.device_id = device_id
    if user.save
      render :json=>{:success => true, :message=>"success to register"}
      return
    else
      render :json=>{:success => false, :message=>"fail to register"}
      return
    end
  end

  def login
    uid = params[:uid]
    profile_url = params[:profile_thumbnail_url]
    user = User.find_by_uid(uid)
    new_token = SecureRandom.hex

    if user
      if user.update_attributes(:access_token => new_token)
        render :json=>{:success => true, :message=>"success to login", :access_token => new_token}
        return
      else
        render :json=>{:success => false, :message=>"fail to login"}
        return
      end
    else
      new_user = User.create(users_param)
      # avatar_url = process_uri(profile_url)
      unless profile_url.nil?
        new_user.update_attribute(:profile, URI.parse(profile_url))
      end

      new_user.access_token = new_token
      # new_user.profile = URI.parse("http://graph.facebook.com/#{uid}/picture?type=large")

      # logger.debug new_user.profile.to_s
      if new_user.save  
        render :json=>{:success => true, :message=>"success to create new user"}
        return
      else
        render :json=>{:success => false, :message=>"fail to create new user"}
        return
      end
    end
  end

  def destroy
    user = User.find_by_access_token(params[:access_token])

    Post.where(:uid => user.uid).destroy_all

    if user.destroy
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
    access_token = params[:access_token]
    new_nick_name = params[:nickname]

    has_user = User.find_by_name(new_nick_name)

    if has_user
      render :json=>{:success => false, :result_code => 1, :message=>"duplicate user name"}
      return
    end

    user = User.find_by_access_token(access_token)
    
    if (user.nil?)
      render :json=>{:success => false, :result_code => 2, :message=>"fail to change nickname. no user found"}
      return      
    end

    if (user.update_attributes(:name => new_nick_name))
      render :json=>{:success => true, :result_code => 0, :message=>"success to change nickname"}
      return
    else
      render :json=>{:success => false, :result_code => 2, :message=>"fail to change nickname"}
      return      
    end
  end

  def update
    access_token = params[:access_token]
    user = User.find_by_access_token(access_token)

    profile = params[:profile]
    intro = params[:intro]
     
    if (profile.nil?)
      user.update_attributes(:intro => intro) 
    else
      user.update_attributes(:profile => profile, :intro => intro) 
    end

    if (user.save)
      metadata = {:success => true, :message=>"success to get user."}
      render :json=>{:intro => user.intro, :profile_thumbnail_url => user.profile_thumbnail_url, :success => true, :result_code => 0, :message=>"success to update user."}
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

  def getUserInfoByUID

    uid = params[:uid]
    user = User.find_by_uid(uid)

    if (user.nil?)
      user = User.find_by_uid('999')
      metadata = {:success => true, :message=>"success to get user."}
      respond_with(user, :api_template => :render_user, :root => :user, :meta => metadata)
      # render :json=>{:success => false, :message=>"fail to get user."}
    else
      metadata = {:success => true, :message=>"success to get user."}
      respond_with(user, :api_template => :render_user, :root => :user, :meta => metadata)
    end
  end

  def getUserInfo

  	access_token = params[:access_token]
  	user = User.find_by_access_token(access_token)

  	if (user.nil?)
      user = User.find_by_uid('999')
      metadata = {:success => true, :message=>"success to get user."}
      respond_with(user, :api_template => :render_user, :root => :user, :meta => metadata)
  	else
      metadata = {:success => true, :message=>"success to get user."}
      respond_with(user, :api_template => :render_user, :root => :user, :meta => metadata)
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

private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def users_param
      params.permit(:name, :email, :uid)
    end

    def process_uri(uri)
      require 'open-uri'
      require 'open_uri_redirections'
      open(uri, :allow_redirections => :safe) do |r|
        r.base_uri.to_s
      end
    end
end
