require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { User.new(name: 'TestUser').save }
  let(:user2) { User.new(provider: 'TestUser').save }
  context 'positive validation test' do
    it 'ensures presence of name' do
      expect(user1).to eq(true)
    end
  end

  context 'negative validation test' do
    it 'ensures presence of name' do
      expect(user2).to eq(false)
    end
    it 'ensures uniquness of name' do
      user1
      user3 = User.new(name: 'TestUser').save
      expect(user3).to eq(false)
    end
  end
end
