class MatchingController < ApplicationController
  before_action :authenticate_user!

  def index
    favorite_user_ids = Favorite.where(to_user_id: current_user.id, status: 1).pluck(:from_user_id)
    @matching = Favorite.where(to_user_id: favorite_user_ids, from_user_id: current_user.id, status: 1).map(&:to_user)
  end
end
