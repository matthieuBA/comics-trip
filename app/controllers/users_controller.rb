class UsersController < ApplicationController

  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    if current_user == @user
      render 'show'
    else
      redirect_to root_path
    end
  end

  def follow(user_id)
    followed_users.create(followee_id: user_id)
  end

  def unfollow(user_id)
    followed_users.find_by(followee_id: user_id).destroy
  end
  
end