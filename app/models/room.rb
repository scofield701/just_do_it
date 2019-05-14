class Room < ApplicationRecord
  has_many :messages
  has_many :room_users
  has_many :users, through: :members

  def last_message
    if (last_message = messages.last).present?
      last_message.message? ? last_message.message : '画像が投稿されています'
    else
      'まだメッセージはありません。'
    end
  end
end
