require 'rails_helper'

RSpec.feature 'New Group page', type: :feature do
  before(:each) do
    visit root_path
    within('form') do
      fill_in 'name', with: 'user1'
    end
    click_button 'login'
    visit groups_path
    click_link 'New Group'
  end
  it 'allows user to create a new group' do
    within('form') do
      fill_in 'group_name', with: 'Test Group'
      fill_in 'group_icon', with: 'Test Icon'
    end
    expect { click_button 'Create Group' }.to change(Group, :count).by(1)
  end
end

RSpec.feature 'New Group page', type: :feature do
  before(:each) do
    visit root_path
    within('form') do
      fill_in 'name', with: 'user1'
    end
    click_button 'login'
    visit groups_path
    click_link 'New Group'
  end
  it 'prevents user from creating a new group without a name' do
    within('form') do
      fill_in 'group_icon', with: 'Test Icon'
    end
    click_button 'Create Group'
    expect(page).to have_content("Name can't be blank")
  end
  it 'prevents user from creating a new group without a icon' do
    within('form') do
      fill_in 'group_name', with: 'Test Group'
    end
    click_button 'Create Group'
    expect(page).to have_content("Icon can't be blank")
  end
end
