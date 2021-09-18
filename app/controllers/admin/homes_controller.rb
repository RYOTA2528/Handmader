class Admin::HomesController < ApplicationController
   before_action :authenticate_admin!,  except: [:top]

  def top
#   @user = User.new
#   @users = User.all
#   @users = User.page(params[:page]).per(10)
  end
end
