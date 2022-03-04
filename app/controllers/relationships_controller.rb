class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:followed_id]) # followしたいユーザー
    follow_action = current_user.follow(@user)
    follow_action.build_activity(activity_params)
    follow_action.save
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed # unfollowしたいユーザー
    current_user.unfollow(@user)
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  private
  def activity_params
    params.permit(:user_id)
  end
end