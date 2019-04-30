class ChatController < ApplicationController
  before_action :authenticate_user!

  def create
    user_rooms = RoomUser.where(user_id: current_user.id).map(&:room)
    chat_room = RoomUser.where(room: user_rooms, user_id: params[:user_id]).map(&:room).first
    if chat_room.blank?
      chat_room = Room.create
      RoomUser.create(room: chat_room, user_id: current_user.id)
      RoomUser.create(room: chat_room, user_id: params[:user_id])
    end
    redirect_to action: :show, id: chat_room.id
  end

  def show
    room = Room.find_by(id: params[:id])
    @room_user = room.room_users.
      where.not(user_id: current_user.id).first.user
    @messages = Message.where(room: room).order(:created_at)
  end
end
