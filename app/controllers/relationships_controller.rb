class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:followed_id]) # followしたいユーザー
    follow_action = current_user.follow(@user)
    follow_action.build_activity(activity_params)
    follow_action.save
    redirect_to @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed # unfollowしたいユーザー
    current_user.unfollow(@user)
    redirect_to @user
  end

  private
  def activity_params
    params.permit(:user_id)
  end
end