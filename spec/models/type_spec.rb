require 'rails_helper'

RSpec.describe Type, type: :model do
  let(:type1) { Type.new(amount_type: 'TestType').save }
  context 'positive validation test' do
    it 'ensures presence of amount_type' do
      expect(type1).to eq(true)
    end
  end

  context 'negative validation test' do
    it 'ensures presence of amount_type' do
      type2 = Type.new(amount_type: nil).save
      expect(type2).to eq(false)
    end
    it 'ensures uniquness of amount_type' do
      type1
      type3 = Type.new(amount_type: 'TestType').save
      expect(type3).to eq(false)
    end
  end
end
