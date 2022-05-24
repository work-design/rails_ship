require 'test_helper'
class Ship::Admin::CarsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @car = cars(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/admin/cars')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/admin/cars')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Car.count') do
      post(
        url_for(controller: 'ship/admin/cars', action: 'create'),
        params: { car: { detail: @ship_admin_car.detail, location: @ship_admin_car.location, member_id: @ship_admin_car.member_id, number: @ship_admin_car.number, registration: @ship_admin_car.registration, user_id: @ship_admin_car.user_id } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/admin/cars', action: 'show', id: @car.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/admin/cars', action: 'edit', id: @car.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/admin/cars', action: 'update', id: @car.id),
      params: { car: { detail: @ship_admin_car.detail, location: @ship_admin_car.location, member_id: @ship_admin_car.member_id, number: @ship_admin_car.number, registration: @ship_admin_car.registration, user_id: @ship_admin_car.user_id } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Car.count', -1) do
      delete url_for(controller: 'ship/admin/cars', action: 'destroy', id: @car.id), as: :turbo_stream
    end

    assert_response :success
  end

end
