class Public::RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:following_id])
    current_user.active_follow(@user)
  end

  def destroy
    @user = User.find(params[:id])
    current_user.delete_follow(@user)
  end
end
