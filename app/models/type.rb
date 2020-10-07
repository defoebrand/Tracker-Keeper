class Type < ApplicationRecord
  validates :amount_type, uniqueness: true
  has_many :tracktions

  def amount_type=(value)
    super(value.try(:strip))
  end
end
