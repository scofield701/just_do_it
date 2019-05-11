class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @sex   = user_sex?(@user)
    user_ids = Favorite.where(from_user_id: current_user.id).pluck(:to_user_id)
    @users = User.where.not(id: current_user.id).where.not(id: user_ids).where(sex: @sex)
  end

  def show
    @user = User.find(params[:id])
    @favorite = Favorite.find_by(to_user_id: @user.id, from_user_id: current_user.id)
  end

  def search
  end

  def search_result
    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true).order(id: "DESC")
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def search_params
    params.require(:q).permit(:sex_eq)
  end
end
