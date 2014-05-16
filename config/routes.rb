GollazoApi::Application.routes.draw do

  get "attachments/create"
  match 'users(.format)' => "users#create", :via => :post 
  match 'users/login(.format)' => "users#login", :via => :post 
  match 'users/register_gcm(.format)' => "users#registerGCM", :via => :post 
  match 'users(.format)' => "users#destroy", :via => :delete
  match 'users/update(.format)' => "users#update", :via => :post 
  match 'users/get_userinfo(.format)' => "users#getUserInfo", :via => :get
  match 'users/get_userinfo_by_uid(.format)' => "users#getUserInfoByUID", :via => :get
  match 'users/get_user_list(.format)' => "users#getUserList", :via => :get
  match 'users/get_nickname_uniqueness(.format)' => "users#checkUniqueness", :via => :get 
  
  match 'users/change_imei(.format)' => "users#devModifyIMEI", :via => :post 
  match 'users/change_nickname(.format)' => "users#updateNickname", :via => :post 

  match 'posts(.format)' => "posts#create", :via => :post 
  match 'posts/:id(.format)' => "posts#destroy", :via => :delete
  match 'posts/update(.format)' => "posts#update", :via => :post
  match 'posts(.format)' => "posts#show", :via => :get
  match 'posts/get_post_by_category(.format)' => "posts#getPostsByCategory", :via => :get
  match 'posts/add_comment(.format)' => "posts#add_reply", :via => :post 
  match 'posts/bomb_post(.format)' => "posts#bombPost", :via => :post
  match 'posts/cancel_bomb_post(.format)' => "posts#cancelBomb", :via => :post
  match 'posts/get_post_by_user(.format)' => "posts#getPostsByAccessToken", :via => :get
  match 'posts/get_voted_post_by_user(.format)' => "posts#getVotedPosts", :via => :get
  match 'posts/vote_post(.format)' => "posts#votePost", :via => :post 
  match 'posts/get_my_menu_count(.format)' => "posts#getMenuCount", :via => :get
  match 'posts/get_voted_users(.format)' => "posts#getVotedUsers", :via => :get
  
  match 'items(.json)' => "items#create", :via => :post
  match 'items/up_vote(.json)' => "items#up_vote", :via => :post
  match 'items/down_vote(.json)' => "items#down_vote", :via => :post

  match 'attachments(.json)' => "attachments#create", :via => :post

  match 'services/sla(.format)' => "services#sla", :via => :get
  match 'services/pla(.format)' => "services#pla", :via => :get
  
  #match 'posts/delete_all(.format)' => "posts#deleteAll", :via => :post
end
