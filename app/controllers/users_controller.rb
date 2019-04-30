class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @favorite = Favorite.find_by(to_user_id: @user.id, from_user_id: current_user.id)
  end

  def search
  end

  def like_user
    @user  = User.find(params[:id])
    @users = @user.followings
  end

  def nope_user
    @user  = User.find(params[:id])
    @users = @user.followers
  end
end
