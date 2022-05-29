require 'test_helper'
class Ship::Admin::ShipmentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @shipment = shipments(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/admin/shipments')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/admin/shipments')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Shipment.count') do
      post(
        url_for(controller: 'ship/admin/shipments', action: 'create'),
        params: { shipment: { arrived_at: @ship_admin_shipment.arrived_at, car_id: @ship_admin_shipment.car_id, driver_id]: @ship_admin_shipment.driver_id], left_at: @ship_admin_shipment.left_at, line_id: @ship_admin_shipment.line_id, load_on: @ship_admin_shipment.load_on, state: @ship_admin_shipment.state } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/admin/shipments', action: 'show', id: @shipment.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/admin/shipments', action: 'edit', id: @shipment.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/admin/shipments', action: 'update', id: @shipment.id),
      params: { shipment: { arrived_at: @ship_admin_shipment.arrived_at, car_id: @ship_admin_shipment.car_id, driver_id]: @ship_admin_shipment.driver_id], left_at: @ship_admin_shipment.left_at, line_id: @ship_admin_shipment.line_id, load_on: @ship_admin_shipment.load_on, state: @ship_admin_shipment.state } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Shipment.count', -1) do
      delete url_for(controller: 'ship/admin/shipments', action: 'destroy', id: @shipment.id), as: :turbo_stream
    end

    assert_response :success
  end

end
