class PostsController < ApiController
  respond_to :json, :xml

  def create 
  	@post = Post.new(params[:post])

    if @post.save
      render :json=>{:success => true, :message=>"success to create new post."}
      return
    else
      render :json=>{:success => false, :message=>"fail to create new post."}
      return  		
    end
  end

  def show
  	@post = Post.find(params[:id])

  	if (@post.nil?)
	  render :json=>{:success => false, :message=>"cannot find post"}
	  return      
	end
	metadata = {:success => true, :message=>"success to get replies."}
    respond_with(@post, :api_template => :render_post, :meta => metadata)  	
  end

  def getPostsByCategory 
	@posts = Post.where("category_code = ?", params[:category_code]).page(params[:page]).order('created_at DESC')
	if (@posts.nil?)
		render :json=>{:success => false, :message=>"fail to get posts."}
	else
		metadata = {:success => true, :message=>"success to get posts.", :posts_count => @posts.count}
		respond_with(@posts, :api_template => :render_post_list, :root => :posts, :meta => metadata)
	end
  end

  def add_reply
	@post = Post.find(params[:id])
	@comment = @post.replies.build(:content => params[:content], :selected_num => params[:selected_num], :user_id => params[:user_id])
	if @post.save 
	    render :json => {:success => true, :result_code => 0, :comment => @comment, :message => "succeed to create comment"}
	else
	    render :json => {:success => false, :result_code => 2, :comment => @comment.errors, :message => "fail to create comment"}
	end
  end
end
