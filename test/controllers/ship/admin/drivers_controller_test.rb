require 'test_helper'
class Ship::Admin::DriversControllerTest < ActionDispatch::IntegrationTest

  setup do
    @driver = drivers(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/admin/drivers')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/admin/drivers')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Driver.count') do
      post(
        url_for(controller: 'ship/admin/drivers', action: 'create'),
        params: { driver: { detail: @ship_admin_driver.detail, name: @ship_admin_driver.name, number: @ship_admin_driver.number, user_id: @ship_admin_driver.user_id } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/admin/drivers', action: 'show', id: @driver.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/admin/drivers', action: 'edit', id: @driver.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/admin/drivers', action: 'update', id: @driver.id),
      params: { driver: { detail: @ship_admin_driver.detail, name: @ship_admin_driver.name, number: @ship_admin_driver.number, user_id: @ship_admin_driver.user_id } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Driver.count', -1) do
      delete url_for(controller: 'ship/admin/drivers', action: 'destroy', id: @driver.id), as: :turbo_stream
    end

    assert_response :success
  end

end
