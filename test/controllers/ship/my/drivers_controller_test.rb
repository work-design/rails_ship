require 'test_helper'
class Ship::My::DriversControllerTest < ActionDispatch::IntegrationTest

  setup do
    @ship_my_driver = create ship_my_drivers
  end

  test 'index ok' do
    get my_drivers_url
    assert_response :success
  end

  test 'new ok' do
    get new_my_driver_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Driver.count') do
      post my_drivers_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get my_driver_url(@ship_my_driver)
    assert_response :success
  end

  test 'edit ok' do
    get edit_my_driver_url(@ship_my_driver)
    assert_response :success
  end

  test 'update ok' do
    patch my_driver_url(@ship_my_driver), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Driver.count', -1) do
      delete my_driver_url(@ship_my_driver)
    end

    assert_response :success
  end

end
