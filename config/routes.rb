GollazoApi::Application.routes.draw do

  match 'users(.format)' => "users#create", :via => :post 
  match 'users(.format)' => "users#destroy", :via => :delete
  match 'users/update(.format)' => "users#update", :via => :post 
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
  match 'posts/vote_post(.format)' => "posts#votePost", :via => :post 
  match 'posts/get_my_menu_count(.format)' => "posts#getMenuCount", :via => :get
  
  match 'items(.json)' => "items#create", :via => :post
  match 'items/up_vote(.json)' => "items#up_vote", :via => :post
  match 'items/down_vote(.json)' => "items#down_vote", :via => :post

  match 'services/sla(.format)' => "services#sla", :via => :get
  match 'services/pla(.format)' => "services#pla", :via => :get

  #match 'posts/delete_all(.format)' => "posts#deleteAll", :via => :post
end
