require 'rails_helper'

RSpec.describe Tracktion, type: :model do
  context 'positive validation test' do
    it 'ensures presence of author, name, amount, and type' do
      track = Tracktion.new(author_id: 1, name: 'Track1', amount: 23, type_id: 1).save
      expect(track).to eq(true)
    end
  end
  context 'belongs_to validation test' do
    it 'ensures presence of valid author' do
      track = Tracktion.new(author_id: 2, name: 'Track1', amount: 23, type_id: 1).save
      expect(track).to eq(false)
    end
    it 'ensures presence of valid type' do
      track = Tracktion.new(author_id: 1, name: 'Track1', amount: 23, type_id: 2).save
      expect(track).to eq(false)
    end
  end
end

RSpec.describe Tracktion, type: :model do
  context 'missing value test' do
    it 'ensures presence of author' do
      track = Tracktion.new(name: 'Track1', amount: 23, type_id: 1).save
      expect(track).to eq(false)
    end
    it 'ensures presence of name' do
      track = Tracktion.new(author_id: 1, amount: 23, type_id: 1).save
      expect(track).to eq(false)
    end
    it 'ensures presence of amount' do
      track = Tracktion.new(author_id: 1, name: 'Track1', type_id: 1).save
      expect(track).to eq(false)
    end
    it 'ensures presence of type' do
      track = Tracktion.new(author_id: 1, name: 'Track1', amount: 23).save
      expect(track).to eq(false)
    end
  end
end
