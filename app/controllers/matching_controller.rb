class MatchingController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = current_user.rooms
    room_users_ids = RoomUser.where(room_id: @rooms).where.not(user_id: current_user.id).pluck(:user_id)
    @room_users = User.where(id: room_users_ids)
  end
end
