class Group < ApplicationRecord
  validates :name, :icon, presence: true, uniqueness: true
  has_and_belongs_to_many :tracktions
end
