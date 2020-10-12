class Group < ApplicationRecord
  validates :name, :icon, presence: true
  validates :name, uniqueness: true
  has_and_belongs_to_many :tracktions
end
