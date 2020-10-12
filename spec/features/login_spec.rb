require 'rails_helper'

RSpec.feature 'Correct login', type: :feature do
  before(:each) do
    visit root_path
    within('form') do
      fill_in 'name', with: 'user1'
    end
    click_button 'login'
  end
  it 'allows user to log in with a valid name' do
    visit user_path(User.find(1))
    expect(page).to have_content('New Transaction')
  end
  it 'allows user to navigate to new transaction page' do
    visit user_path(User.find(1))
    click_link 'New Transaction'
    expect(page).to have_content('Name of Transaction')
    expect(page).to have_content('Amount of Transaction')
  end
end

RSpec.feature 'Incorrect login', type: :feature do
  before(:each) do
    visit root_path
    within('form') do
      fill_in 'name', with: 'user2'
    end
    click_button 'login'
  end
  it 'reports error and keeps user on splash page' do
    expect(page).not_to have_content('New Transaction')
    expect(page).to have_content('Name or email is invalid')
    expect(page).to have_button('login')
  end
  it 'denies use access to site features' do
    expect { visit(user_path(1)) }.to raise_error(ActiveRecord::RecordNotFound)
    expect { visit(tracktion_path(1)) }.to raise_error(ActiveRecord::RecordNotFound)
    expect { visit(type_path(1)) }.to raise_error(ActiveRecord::RecordNotFound)
    expect { visit(group_path(1)) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end

RSpec.feature 'Logging in', type: :feature do
  before(:each) do
    visit root_path
    within('form') do
      fill_in 'name', with: 'user1'
    end
    click_button 'login'
  end
  it 'allows user to navigate to new tracktion page' do
    visit new_tracktion_path
    expect(page).to have_content('New Tracktion')
    expect(page).to have_content('Name of Transaction')
    expect(page).to have_button('Create Tracktion')
  end
  it 'allows user to navigate to new group page' do
    visit new_group_path
    expect(page).to have_content('New Group')
    expect(page).to have_content('Add New Icon *')
    expect(page).to have_button('Create Group')
  end
  it 'allows user to navigate to new type page' do
    visit new_type_path
    expect(page).to have_content('New Amount Type')
    expect(page).to have_content('Name of type')
    expect(page).to have_button('Create Type')
  end
end
