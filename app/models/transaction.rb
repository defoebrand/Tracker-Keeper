class Transaction < ApplicationRecord
  belongs_to :user
  # belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
end
