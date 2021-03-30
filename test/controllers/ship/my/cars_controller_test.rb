require 'test_helper'
class Ship::My::CarsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @ship_my_car = create ship_my_cars
  end

  test 'index ok' do
    get my_cars_url
    assert_response :success
  end

  test 'new ok' do
    get new_my_car_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Car.count') do
      post my_cars_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get my_car_url(@ship_my_car)
    assert_response :success
  end

  test 'edit ok' do
    get edit_my_car_url(@ship_my_car)
    assert_response :success
  end

  test 'update ok' do
    patch my_car_url(@ship_my_car), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Car.count', -1) do
      delete my_car_url(@ship_my_car)
    end

    assert_response :success
  end

end
