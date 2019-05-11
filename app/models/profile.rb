class Profile < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :birth_year
  belongs_to_active_hash :birth_month

  belongs_to :user
end
