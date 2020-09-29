class Type < ApplicationRecord
  validates :amount_type, uniqueness: true
end
