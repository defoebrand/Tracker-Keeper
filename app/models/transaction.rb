class Transaction < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :group
  # accepts_nested_attributes_for :group
end
