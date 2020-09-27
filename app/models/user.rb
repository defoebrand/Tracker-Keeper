class User < ApplicationRecord
  has_many :transactions
  validates :name, uniqueness: true
end
