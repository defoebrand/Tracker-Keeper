class User < ApplicationRecord
  has_many :transactions
  validates :name, uniqueness: true
  has_one_attached :avatar
end
