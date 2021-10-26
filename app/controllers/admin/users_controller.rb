class Admin::UsersController < ApplicationController
# before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end

  def update
  @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to admin_user_path(@user)
    flash[:notice]='ユーザーの情報を更新しました'
    else
    render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :encrypted_password, :is_deleted, :nickname, :profile, :avatar)
  end

end
