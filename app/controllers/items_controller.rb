class ItemsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  
  def create 
  	@item = Item.new(item_params)

    if @item.save
      render :json=>{:success => true, :message=>"success to create new item."}
      return
    else
      render :json=>{:success => false, :message=>"fail to create new item."}
      return  		
    end
  end

  def up_vote
  	@id = params[:id]
  	@imei = params[:imei]
  	@item = Item.find(@id)

  	@user = User.cachedUserInfo(@imei)
    if (@user.nil?)
      @user = User.getUserInfo(@imei);
    end

    if (@user.nil?)
      render :json=>{:success => false, :message=>"cannot find user."}
      return 
    end

    @success = @item.vote :voter => @user, :vote => 'like'

    if @success
      render :json=>{:success => true, :message=>"success to vote"}
      return
    else
      render :json=>{:success => false, :message=>"fail to vote."}
      return 
    end
  end

  def down_vote
  	@id = params[:id]
  	@imei = params[:imei]
  	@item = Item.find(@id)

  	@user = User.cachedUserInfo(@imei)
    if (@user.nil?)
      @user = User.getUserInfo(@imei);
    end

    if (@user.nil?)
      render :json=>{:success => false, :message=>"cannot find user."}
      return 
    end

    @success = @item.vote :voter => @user, :vote => 'bad'

    if @success
      render :json=>{:success => true, :message=>"success to vote"}
      return
    else
      render :json=>{:success => false, :message=>"fail to vote."}
      return 
    end
  end

  private
  def item_params
    params.require(:item).permit(:description, :post_id, :photo)
  end

end
