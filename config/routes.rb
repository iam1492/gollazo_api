GollazoApi::Application.routes.draw do

  match 'users(.format)' => "users#create", :via => :post 
  match 'users/get_userinfo(.format)' => "users#getUserInfo", :via => :get
  match 'users/get_user_list(.format)' => "users#getUserList", :via => :get
  match 'users/get_nickname_uniqueness(.format)' => "users#checkUniqueness", :via => :get 
  
  match 'posts(.format)' => "posts#create", :via => :post 
  match 'posts/update(.format)' => "posts#update", :via => :post
  match 'posts(.format)' => "posts#show", :via => :get
  match 'posts/get_post_by_category(.format)' => "posts#getPostsByCategory", :via => :get
  match 'posts/add_comment(.format)' => "posts#add_reply", :via => :post 
  match 'posts/bomb_post(.format)' => "posts#bombPost", :via => :post
  match 'posts/get_post_by_imei(.format)' => "posts#getPostsByImei", :via => :get
  match 'posts/get_voted_post_by_imei(.format)' => "posts#getVotedPosts", :via => :get
end
