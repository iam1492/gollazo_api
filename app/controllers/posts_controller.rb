class PostsController < ApiController
  require 'gcm'

  skip_before_filter  :verify_authenticity_token

  respond_to :json, :xml
  def create 
    access_token = posts_param[:access_token]

    user = User.find_by_access_token(access_token)
  	post = Post.create(category_code: posts_param[:category_code], description: posts_param[:description], title: posts_param[:title], uid: user.uid)

    if post.save
      render :json=>{:success => true, :post_id => post.id, :message=>"success to create new post."}
      return
    else
      render :json=>{:success => false, :message=>"fail to create new post."}
      return  		
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      render :json=>{:success => true, :message=>"success to destroy post."}
      return
    else
      render :json=>{:success => false, :message=>"fail to destroy post."}
      return      
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(:category_code => params[:category_code], 
                            :description => params[:description], 
                            :title => params[:title])

    if @post.save
      render :json=>{:success => true, :result_code => 0, :message=>"success to update post."}
    else
      render :json=>{:success => false, :result_code => 2, :message=>"fail to update post."}
    end
  end

  def show
    access_token = params[:access_token]
    user = User.find_by_access_token(access_token)

  	post = Post.find(params[:id])

    if (user.nil?)
      render :json=>{:success => false, :message=>"cannot not find user"}
      return
    end

  	if (post.nil?)
	   render :json=>{:success => false, :message=>"cannot find post"}
	   return      
	  end

    has_voted = user.voted_up_on?(post)
    selected_nums = post.getSelectedNum (user.id)

    if post.isMyPost? user.uid
      my_post = true
    else
      my_post = false
    end

    metadata = {:success => true, :message=>"success to get post detail.", 
      :has_voted => has_voted,  :selected_num => selected_nums, :my_post => my_post }
    
    respond_with(post, :api_template => :render_post, :meta => metadata)  	
  end

  def votePost
    access_token = params[:access_token]
    user = User.find_by_access_token(access_token)

    post = Post.find(params[:id])
    
    selected_nums = params[:selected_nums]

    if (user.voted_up_on? post)
      render :json=>{:success => false, :message=>"already voted"}
    else
      #vote here
      post.selections.create!(:user_id => user.id, :selected_items => selected_nums)

      seletedNumsArray = selected_nums.split(/,/)

      seletedNumsArray.each do |num|

        item = post.items.find(num.to_i)
        if (item.up_vote user)
          logger.debug "vote to : #{num}"
        else
          render :json=>{:success => false, :message=>"already voted"}
          return
        end
      end
    
      gcm = GCM.new('AIzaSyA6gVccPySYRX9mK1Lt0ArUZdJPmIAJkF0')
      post_user = User.find_by_uid(post.uid)

      unless post_user.nil?
        registration_ids= [post_user.device_id] # an array of one or more client registration IDs
        options = {data: {type: 1, msg: 'Someone Like to your post', 
          post_id: post.id, description: post.description, 
          title: post.title, name: post.name, item_count: post.items.count}}
        response = gcm.send_notification(registration_ids, options)
      end

      post.vote(:voter => user)

      render :json=>{:success => true, :message=>"vote success"}
      return
    end
  end

  def getPostsByCategory 
    category_params = params[:category_code];

    if (!category_params.nil?)
      category_array = params[:category_code].split(/,/)
    end

    if (category_array.nil?)
  	  posts = Post.page(params[:page]).order('created_at DESC')
    else
      posts = Post.where(:category_code => category_array).page(params[:page]).order('created_at DESC')
    end

  	if (posts.nil?)
  		render :json=>{:success => false, :message=>"fail to get posts."}
  	else
  		metadata = {:success => true, :message=>"success to get posts.", :posts_count => posts.count}
  		respond_with(posts, :api_template => :render_post_list, :root => :posts, :meta => metadata)
  	end
  end

  def getPostsByAccessToken
    access_token = params[:access_token]
    user = User.find_by_access_token(access_token)

    posts = Post.where("uid = ?", user.uid).page(params[:page]).order('created_at DESC')
    if (posts.nil?)
      render :json=>{:success => false, :message=>"fail to get posts."}
    else
      metadata = {:success => true, :message=>"success to get posts.", :posts_count => posts.count}
      respond_with(posts, :api_template => :render_post_list, :root => :posts, :meta => metadata)
    end
  end

  def getVotedPosts
    access_token = params[:access_token]
    user = User.find_by_access_token(access_token)
    # @user = User.cachedUserInfo(@imei)
    # if (user.nil?)
    #   @user = User.getUserInfo(@imei);
    # end

    votables = user.find_votes(:votable_type => 'Post').page(params[:page]).order('created_at DESC')
    posts_ids = votables.map{|post| post.votable_id}
    posts = Post.find_all_by_id(posts_ids)
    if (posts.nil?)
      render :json=>{:success => false, :message=>"fail to get posts."}
    else
      metadata = {:success => true, :message=>"success to get posts.", :posts_count => posts.count}
      respond_with(posts, :api_template => :render_post_list, :root => :posts, :meta => metadata)
    end
  end

  def getVotedUsers
    post = Post.find(params[:id])

    if (post.nil?)
      render :json=>{:success => false, :message=>"fail to get posts."}
    end

    voters = post.find_votes(:voter_type => 'User').page(params[:page]).order('created_at DESC')
    users_ids = voters.map{|user| user.voter_id}
    users = User.find_all_by_id(users_ids)

    users.each do |u| 
      u.selection = post.getSelectedNum(u.id)  
    end
    
    if (users.nil?)
      render :json=>{:success => false, :message=>"fail to get users."}
    else
      metadata = {:success => true, :message=>"success to get voted users.", :users_count => users.count}
      respond_with(users, :api_template => :render_user_with_selection, :root => :users, :meta => metadata)
    end
  end

  def getMenuCount
    access_token = params[:access_token]
    user = User.find_by_access_token(access_token)

    # @imei = params[:imei]
    # @user = User.cachedUserInfo(@imei)
    # if (@user.nil?)
    #   @user = User.getUserInfo(@imei);
    # end
    vote_count = user.find_votes(:votable_type => 'Post').size
    post_count = Post.count(:conditions => "uid LIKE \'#{user.uid}\'")

    render :json=>{:success => true, :vote_count => vote_count, :post_count => post_count}
  end

  def bombPost
    
    access_token = params[:access_token]

    user = User.find_by_access_token(access_token)

    post_id = params[:id]
    post = Post.find(post_id)  
    isMyPost = post.isMyPost? user.uid

    if isMyPost
      if (post.isBombed)
        render :json=>{:success => true, :result_code => 1, :message=>"already bombed post"}
        return     
      else
        post.isBombed = true
        if post.save
          render :json=>{:success => true, :result_code => 0, :message=>"success to bomb"}
          return     
        else
          render :json=>{:success => false, :result_code => 2, :message=>"fail to bomb"}
          return     
        end
      end
    else
      render :json=>{:success => false, :result_code => 2, :message=>"no permission"}
      return   
    end
  end

  def cancelBomb
    post_id = params[:id]
    post = Post.find(post_id)  
    post.isBombed = false
    if post.save
      render :json=>{:success => true, :result_code => 0, :message=>"success to cancel bomb"}
      return     
    else
      render :json=>{:success => false, :result_code => 2, :message=>"fail to cancel bomb"}
      return     
    end
  end
 
  def add_reply

  	post = Post.find(params[:id])

    access_token = params[:access_token]
    user = User.find_by_access_token(access_token)

    if (user.nil?)
      render :json=>{:success => false, :message=>"user is null"}
      return      
    end

  	comment = post.comments.build(:content => params[:content], :uid => user.uid)

  	if post.save 
      unless post.isMyPost?user.uid
        gcm = GCM.new('AIzaSyA6gVccPySYRX9mK1Lt0ArUZdJPmIAJkF0')
        post_user = User.find_by_uid(post.uid)

        unless post_user.nil?
          registration_ids= [post_user.device_id] # an array of one or more client registration IDs
          options = {data: {type: 1, msg: 'Someone comment to your post', 
            post_id: post.id, description: post.description, 
            title: post.title, name: post.name, item_count: post.items.count}}
          response = gcm.send_notification(registration_ids, options)  
        end
      end
	    render :json => {:success => true, :result_code => 0, :comment => comment, :message => "succeed to create comment"}
  	else
	    render :json => {:success => false, :result_code => 2, :comment => comment.errors, :message => "fail to create comment"}
  	end
  end

  def deleteAll
    @delete = Post.delete_all
    if @delete
        render :json => {:success => true, :result_code => 0, :message => "succeed to delete all"}
    else
        render :json => {:success => false, :result_code => 2, :message => "fail to delete all"}
    end
  end

  private
  def posts_param
    params.permit(:category_code, :description, :title, :access_token)
  end
end
