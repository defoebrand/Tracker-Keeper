class Tracktion < ApplicationRecord
  validates :name, :amount, presence: true
  belongs_to :author, class_name: 'User'
  belongs_to :type
  has_and_belongs_to_many :groups
end
