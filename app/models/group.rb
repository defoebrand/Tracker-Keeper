class Group < ApplicationRecord
  has_many :transactions, dependent: :destroy
end
