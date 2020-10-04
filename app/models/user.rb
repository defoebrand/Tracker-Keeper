class User < ApplicationRecord
  has_many :transactions
  validates :name, uniqueness: true
  validates_length_of :name, minimum: 5, allow_blank: false
  has_one_attached :avatar

  def name=(value)
    super(value.try(:strip))
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid)
      .or(where(name: auth['info']['nickname'][0..19])).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['nickname'][0..19]
    end
  end
end
