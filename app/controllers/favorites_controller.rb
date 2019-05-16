class FavoritesController < ApplicationController
  before_action :set_user

  def create
    favorite = Favorite.new(create_params)
    @user = User.find(params[:favorite][:to_user_id])
    favorite.favorite_count(@user) if favorite.favorite?(params[:favorite][:status])
    favorite.save
    @favorite = Favorite.find_by(to_user_id: @user.id, from_user_id: current_user.id)
    room_create(@user) if matching?(@user, @favorite)
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

  def matching?(user, status)
    @matching = Favorite.find_by(to_user_id: current_user.id, from_user_id: user.id, status: 1)
    return true if @matching.present? && status.status == 1
  end

  def room_create(user)
    user_rooms = RoomUser.where(user_id: current_user.id).map(&:room)
    chat_room = RoomUser.where(room: user_rooms, user_id: user.id).map(&:room).first
    if chat_room.blank?
      chat_room = Room.create
      RoomUser.create(room: chat_room, user_id: current_user.id)
      RoomUser.create(room: chat_room, user_id: user.id)
    end
  end
end
