require 'rails_helper'

RSpec.feature 'New Tracktion page', type: :feature do
  before(:each) do
    visit root_path
    within('form') do
      fill_in 'name', with: 'user1'
    end
    click_button 'login'
    visit user_path(User.find(1))
    click_link 'New Transaction'
  end
  it 'allows user to create a new transaction' do
    within('form') do
      fill_in 'tracktion_name', with: 'Test Transaction'
      fill_in 'tracktion_amount', with: 456
      find('#tracktion_type_id option[value="1"]').select_option
    end
    expect { click_button 'Create Tracktion' }.to change(Tracktion, :count).by(1)
  end
end

RSpec.feature 'New Tracktion page', type: :feature do
  before(:each) do
    visit root_path
    within('form') do
      fill_in 'name', with: 'user1'
    end
    click_button 'login'
    visit user_path(User.find(1))
    click_link 'New Transaction'
  end
  it 'prevents user from creating a new transaction without a name' do
    within('form') do
      fill_in 'tracktion_amount', with: 456
      find('#tracktion_type_id option[value="1"]').select_option
    end
    click_button 'Create Tracktion'
    expect(page).to have_content("Name can't be blank")
  end
end

RSpec.feature 'New Tracktion page', type: :feature do
  before(:each) do
    visit root_path
    within('form') do
      fill_in 'name', with: 'user1'
    end
    click_button 'login'
    visit user_path(User.find(1))
    click_link 'New Transaction'
  end
  it 'prevents user from creating a new transaction without an amount' do
    within('form') do
      fill_in 'tracktion_name', with: 'Test Transaction'
      find('#tracktion_type_id option[value="1"]').select_option
    end
    click_button 'Create Tracktion'
    expect(page).to have_content("Amount can't be blank")
  end
end

RSpec.feature 'New Tracktion page', type: :feature do
  before(:each) do
    visit root_path
    within('form') do
      fill_in 'name', with: 'user1'
    end
    click_button 'login'
    visit user_path(User.find(1))
    click_link 'New Transaction'
  end
  it 'prevents user from creating a new transaction without a type' do
    within('form') do
      fill_in 'tracktion_name', with: 'Test Transaction'
      fill_in 'tracktion_amount', with: 456
    end
    click_button 'Create Tracktion'
    expect(page).to have_content('Type must exist')
  end
end
