class FollowRelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find_by! id: params[:id]
    if current_user.follow @user.id
      flash[:success] = "Vous suivez maintenant le compte de  #{@user.nickname}"
      respond_to do |format|
        format.html { redirect_to request.referrer }
      end
    end
  end

  def destroy
    @user = User.find_by! id: params[:id]
    if current_user.unfollow @user.id
      flash[:error] = "Vous ne suivez plus le compte de #{@user.nickname}"
      respond_to do |format|
        format.html { redirect_to request.referrer }
      end
    end
  end
end
