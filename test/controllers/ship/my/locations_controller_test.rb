require 'test_helper'
class Ship::My::LocationsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @ship_my_location = create ship_my_locations
  end

  test 'index ok' do
    get my_locations_url
    assert_response :success
  end

  test 'new ok' do
    get new_my_location_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Location.count') do
      post my_locations_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get my_location_url(@ship_my_location)
    assert_response :success
  end

  test 'edit ok' do
    get edit_my_location_url(@ship_my_location)
    assert_response :success
  end

  test 'update ok' do
    patch my_location_url(@ship_my_location), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Location.count', -1) do
      delete my_location_url(@ship_my_location)
    end

    assert_response :success
  end

end
