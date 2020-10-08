require 'rails_helper'

RSpec.feature 'New Type page', type: :feature do
  before(:each) do
    visit root_path
    within('form') do
      fill_in 'name', with: 'user1'
    end
    click_button 'login'
    visit new_tracktion_path
    click_link 'New Type'
  end
  it 'allows user to create a new type' do
    within('form') do
      fill_in 'type_amount_type', with: 'TestType'
    end
    expect { click_button 'Create Type' }.to change(Type, :count).by(1)
  end
end

RSpec.feature 'New Type page', type: :feature do
  before(:each) do
    visit root_path
    within('form') do
      fill_in 'name', with: 'user1'
    end
    click_button 'login'
    visit new_tracktion_path
    click_link 'New Type'
  end
  it 'prevents user from creating a new type without input' do
    within('form') do
      fill_in 'type_amount_type', with: ''
    end
    click_button 'Create Type'
    expect(page).to have_content("Amount type can't be blank")
  end
end
