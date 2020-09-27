class Group < ApplicationRecord
  has_many :transactions, dependent: :destroy
  validates :name, :icon, presence: true
end
