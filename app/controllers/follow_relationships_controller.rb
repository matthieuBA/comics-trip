class FollowRelationshipsController < ApplicationController
  
  before_action :authenticate_user!

    def follow_user
      @user = User.find_by! user_email: params[:user_email]
      if current_user.follow @user.id
           do |format|
          format.html { redirect_to root_path }
          format.js
        end
      end
    end
  
    def unfollow_user
      @user = User.find_by! user_email: params[:user_email]
      if current_user.unfollow @user.id
        respond_to do |format|
          format.html { redirect_to root_path }
          format.js
        end
      end
    end

end
