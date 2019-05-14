class ChatController < ApplicationController
  before_action :authenticate_user!

  def show
    room = Room.find_by(id: params[:id])
    room_user = RoomUser.where(room_id: room).where.not(user_id: current_user.id).first
    @room_user = User.find_by(id: room_user.user_id)
    @messages = Message.where(room_id: room).order(:created_at)
  end

end
