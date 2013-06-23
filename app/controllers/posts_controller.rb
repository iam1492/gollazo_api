class PostsController < ApiController
  respond_to :json, :xml
  def create 
  	@post = Post.new(params[:post])

    if @post.save
      render :json=>{:success => true, :post_id => @post.id, :message=>"success to create new post."}
      return
    else
      render :json=>{:success => false, :message=>"fail to create new post."}
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
  	@post = Post.find(params[:id])
    @imei = params[:imei]


    if (@imei.nil?)
      render :json=>{:success => false, :message=>"imei is nill"}
      return
    end

    @user = User.cachedUserInfo(@imei)

    if (@user.nil?)
      @user = User.getUserInfo(@imei);
    end
    
    if (@user.nil?)
      render :json=>{:success => false, :message=>"cannot not find user"}
      return
    end

  	if (@post.nil?)
	   render :json=>{:success => false, :message=>"cannot find post"}
	   return      
	  end

    @has_voted = @user.voted_up_on?(@post)
    @selected_nums = @post.getSelectedNum (@user.id)
    metadata = {:success => true, :message=>"success to get post detail.", :has_voted => @has_voted,  :selected_num => @selected_nums}
    
    respond_with(@post, :api_template => :render_post, :meta => metadata)  	
  end

  def votePost
    @post = Post.find(params[:id])
    @imei = params[:imei]
    @user = User.getUserInfo(@imei)
    @selected_nums = params[:selected_nums]

    if (@user.voted_up_on? @post)
      render :json=>{:success => false, :message=>"already voted"}
    else
      #vote here
      
      @post.selections.create!(:user_id => @user.id, :selected_items => @selected_nums)

      seletedNumsArray = @selected_nums.split(/,/)

      seletedNumsArray.each do |num|

        item = @post.items.find(num.to_i)
        if (item.up_vote @user)
          logger.debug "vote to : #{num}"
        else
          render :json=>{:success => false, :message=>"already voted"}
          break
        end
      end
    
      @post.vote(:voter => @user)#, :vote_scope => 'post')

      render :json=>{:success => true, :message=>"vote success"}
    end
  end

  def getPostsByCategory 
    @category_params = params[:category_code];

    if (!@category_params.nil?)
      @category_array = params[:category_code].split(/,/)
    end

    if (@category_array.nil?)
  	  @posts = Post.page(params[:page]).order('created_at DESC')
    else
      @posts = Post.where(:category_code => @category_array).page(params[:page]).order('created_at DESC')
    end

  	if (@posts.nil?)
  		render :json=>{:success => false, :message=>"fail to get posts."}
  	else
  		metadata = {:success => true, :message=>"success to get posts.", :posts_count => @posts.count}
  		respond_with(@posts, :api_template => :render_post_list, :root => :posts, :meta => metadata)
  	end
  end

  def getPostsByImei 
    @posts = Post.where("imei = ?", params[:imei]).page(params[:page]).order('created_at DESC')
    if (@posts.nil?)
      render :json=>{:success => false, :message=>"fail to get posts."}
    else
      metadata = {:success => true, :message=>"success to get posts.", :posts_count => @posts.count}
      respond_with(@posts, :api_template => :render_post_list, :root => :posts, :meta => metadata)
    end
  end

  def getVotedPosts
    @imei = params[:imei]
    @user = User.cachedUserInfo(@imei)
    if (@user.nil?)
      @user = User.getUserInfo(@imei);
    end
    @votables = @user.find_votes(:votable_type => 'Post').page(params[:page]).order('created_at DESC')
    @posts_ids = @votables.map{|post| post.votable_id}
    @posts = Post.find_all_by_id(@posts_ids)
    if (@posts.nil?)
      render :json=>{:success => false, :message=>"fail to get posts."}
    else
      metadata = {:success => true, :message=>"success to get posts.", :posts_count => @posts.count}
      respond_with(@posts, :api_template => :render_post_list, :root => :posts, :meta => metadata)
    end
  end

  def getMenuCount
    @imei = params[:imei]
    @user = User.cachedUserInfo(@imei)
    if (@user.nil?)
      @user = User.getUserInfo(@imei);
    end
    vote_count = @user.find_votes(:votable_type => 'Post').size
    post_count = Post.count(:conditions => "imei LIKE \'#{params[:imei]}\'")

    render :json=>{:success => true, :vote_count => vote_count, :post_count => post_count}
  end

  def bombPost
    @imei = params[:imei]
    @post_id = params[:id]
    @post = Post.find(@post_id)  
    isMyPost = @post.isMyPost? @imei

    if isMyPost
      if (@post.isBombed)
        render :json=>{:success => true, :result_code => 1, :message=>"already bombed post"}
        return     
      else
        @post.isBombed = true
        if @post.save
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
 
  def add_reply
  	@post = Post.find(params[:id])
    @imei = params[:imei]
    @user = User.getUserInfo(@imei)

    if (@user.nil?)
      render :json=>{:success => false, :message=>"user is null"}
      return      
    end

  	@comment = @post.comments.build(:content => params[:content], :imei => @imei)

  	if @post.save 
  	    render :json => {:success => true, :result_code => 0, :comment => @comment, :message => "succeed to create comment"}
  	else
  	    render :json => {:success => false, :result_code => 2, :comment => @comment.errors, :message => "fail to create comment"}
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
end
