require 'test_helper'

class TracktionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tracktion = tracktions(:one)
  end

  test 'should get index' do
    get tracktions_url
    assert_response :success
  end

  test 'should get new' do
    get new_tracktion_url
    assert_response :success
  end

  test 'should create tracktion' do
    assert_difference('Tracktion.count') do
      post tracktions_url, params: { tracktion: { amount: @tracktion.amount, author_id: @tracktion.author_id, name: @tracktion.name, type_id: @tracktion.type_id } }
    end

    assert_redirected_to tracktion_url(Tracktion.last)
  end

  test 'should show tracktion' do
    get tracktion_url(@tracktion)
    assert_response :success
  end

  test 'should get edit' do
    get edit_tracktion_url(@tracktion)
    assert_response :success
  end

  test 'should update tracktion' do
    patch tracktion_url(@tracktion), params: { tracktion: { amount: @tracktion.amount, author_id: @tracktion.author_id, name: @tracktion.name, type_id: @tracktion.type_id } }
    assert_redirected_to tracktion_url(@tracktion)
  end

  test 'should destroy tracktion' do
    assert_difference('Tracktion.count', -1) do
      delete tracktion_url(@tracktion)
    end

    assert_redirected_to tracktions_url
  end
end
