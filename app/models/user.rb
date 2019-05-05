class User < ApplicationRecord
  has_many :messages
  has_many :room_users
  has_many :to_user_favorites, foreign_key: "from_user_id", class_name: "Favorite", dependent: :destroy
  has_many :to_users, through: :to_user_favorites
  has_many :from_user_favorites, foreign_key: "to_user_id", class_name: "Favorite", dependent: :destroy
  has_many :from_users, through: :from_user_favorites

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :image, ImageUploader

  enum sex: { 男: 0, 女: 1 }

  def last_message
    if (last_message = messages.last).present?
      last_message.message? ? last_message.message : '画像が投稿されています'
    else
      'まだメッセージはありません。'
    end
  end

end
