require 'rails_helper'

RSpec.feature 'Viewing the show page for', type: :feature do
  let!(:track) { Tracktion.find(1) }
  let!(:group) { Group.find(1) }
  before(:each) do
    visit root_path
    within('form') do
      fill_in 'name', with: 'user1'
    end
    click_button 'login'
    track.groups << group
  end
  after(:each) do
    expect(page).to have_content('Track1')
    expect(page).to have_content('Group1')
    expect(page).to have_content('Tests')
  end
  it 'a transaction shows the transaction name, group name, and type' do
    visit tracktion_path(Tracktion.find(1))
  end
  it 'a group shows the group name, associated transactions, and their types' do
    visit group_path(Group.find(1))
  end
  it 'a type shows the type name, associated transactions, and their primary group' do
    visit type_path(Type.find(1))
  end
end
