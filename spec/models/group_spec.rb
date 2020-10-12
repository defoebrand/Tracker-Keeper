require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:group1) { Group.new(name: 'TestGroup', icon: 'TestIcon').save }
  context 'positive validation test' do
    it 'ensures presence of name and icon' do
      expect(group1).to eq(true)
    end
  end
  context 'negative validation test' do
    it 'ensures presence of name' do
      group = Group.new(icon: 'TestIcon').save
      expect(group).to eq(false)
    end

    it 'ensures presence of icon' do
      group = Group.new(name: 'TestGroup').save
      expect(group).to eq(false)
    end
  end
  context 'negative validation test' do
    it 'ensures uniquness of name' do
      group1
      group2 = Group.new(name: 'TestGroup', icon: 'TestIcon').save
      expect(group2).to eq(false)
    end
  end
end
