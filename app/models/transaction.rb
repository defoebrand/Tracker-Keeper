class Transaction < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'authorid'
  belongs_to :group, optional: true
  validates :name, :amount, :amount_type, presence: true
end
