class Favorite < ApplicationRecord
  belongs_to :to_user, class_name: "User"
  belongs_to :from_user, class_name: "User"
  belongs_to :user, optional: true

  validates :to_user_id, presence: true
  validates :from_user_id, presence: true
  validates :status, presence: true

  def favorite?(status)
    return true if status == "1"
  end

  def favorite_count(user)
    fav_count = user.favorite_count
    fav_count += 1
    user.update(favorite_count: fav_count)
  end

end
