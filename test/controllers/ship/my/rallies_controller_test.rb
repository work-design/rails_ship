require 'test_helper'
class Ship::My::RalliesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @ship_my_rally = create ship_my_rallies
  end

  test 'index ok' do
    get my_rallies_url
    assert_response :success
  end

  test 'new ok' do
    get new_my_rally_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Rally.count') do
      post my_rallies_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get my_rally_url(@ship_my_rally)
    assert_response :success
  end

  test 'edit ok' do
    get edit_my_rally_url(@ship_my_rally)
    assert_response :success
  end

  test 'update ok' do
    patch my_rally_url(@ship_my_rally), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Rally.count', -1) do
      delete my_rally_url(@ship_my_rally)
    end

    assert_response :success
  end

end
