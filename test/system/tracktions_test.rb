require 'application_system_test_case'

class TracktionsTest < ApplicationSystemTestCase
  setup do
    @tracktion = tracktions(:one)
  end

  test 'visiting the index' do
    visit tracktions_url
    assert_selector 'h1', text: 'Tracktions'
  end

  test 'creating a Tracktion' do
    visit tracktions_url
    click_on 'New Tracktion'

    fill_in 'Amount', with: @tracktion.amount
    fill_in 'Author', with: @tracktion.author_id
    fill_in 'Name', with: @tracktion.name
    fill_in 'Type', with: @tracktion.type_id
    click_on 'Create Tracktion'

    assert_text 'Tracktion was successfully created'
    click_on 'Back'
  end

  test 'updating a Tracktion' do
    visit tracktions_url
    click_on 'Edit', match: :first

    fill_in 'Amount', with: @tracktion.amount
    fill_in 'Author', with: @tracktion.author_id
    fill_in 'Name', with: @tracktion.name
    fill_in 'Type', with: @tracktion.type_id
    click_on 'Update Tracktion'

    assert_text 'Tracktion was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Tracktion' do
    visit tracktions_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Tracktion was successfully destroyed'
  end
end
