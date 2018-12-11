class FriendshipsController < ApplicationController

  def create
    if User.find_by(guid: add_friend_params[:id])
      friended_user = User.find_by(guid: add_friend_params[:id])
      current_user.friendships.create(friended_user: friended_user)
    else
      flash[notice] = "That is an invalid user to friend!"
    end
    redirect_to dashboard_path
  end

  private

  def add_friend_params
    params.permit(:id)
  end

end
