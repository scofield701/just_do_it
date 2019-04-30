class FavoritesController < ApplicationController
  def create
    favorite = Favorite.new(create_params)
    @user = User.find(params[:favorite][:to_user_id])
    favorite.favorite_count(@user) if favorite.favorite?(params[:favorite][:status])
    favorite.save
    @favorite = Favorite.find_by(to_user_id: @user.id, from_user_id: current_user.id)
  end

  private

  def create_params
    params.require(:favorite).permit(:to_user_id, :from_user_id, :status)
  end
end
