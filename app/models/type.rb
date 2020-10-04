class Type < ApplicationRecord
  validates :amount_type, uniqueness: true
  has_many :tracktions
end
