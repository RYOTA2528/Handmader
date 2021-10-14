class HomesController < ApplicationController
  before_action :set_action

  def top
  end

  def about
  end
end

private

def set_action
  @user = User.find_by(params[:user_id])
end