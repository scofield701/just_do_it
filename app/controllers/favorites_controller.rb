class FavoritesController < ApplicationController
  before_action :set_user

  def create
    favorite = Favorite.new(create_params)
    @user = User.find(params[:favorite][:to_user_id])
    favorite.favorite_count(@user) if favorite.favorite?(params[:favorite][:status])
    favorite.save
    @favorite = Favorite.find_by(to_user_id: @user.id, from_user_id: current_user.id)
  end

  def following
    user_ids = Favorite.where(from_user_id: current_user.id, status: 1).pluck(:to_user_id)
    @users = User.where(id: user_ids)
  end

  def follower
    user_ids = Favorite.where(to_user_id: current_user.id, status: 1).pluck(:from_user_id)
    @users = User.where(id: user_ids)
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def create_params
    params.require(:favorite).permit(:to_user_id, :from_user_id, :status)
  end
end
