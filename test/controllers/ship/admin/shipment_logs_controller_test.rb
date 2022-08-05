require 'test_helper'
class Ship::Admin::ShipmentLogsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @shipment_log = shipment_logs(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/admin/shipment_logs')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/admin/shipment_logs')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('ShipmentLog.count') do
      post(
        url_for(controller: 'ship/admin/shipment_logs', action: 'create'),
        params: { shipment_log: { arrived_at: @ship_admin_shipment_log.arrived_at, expected_leave_at: @ship_admin_shipment_log.expected_leave_at, left_at: @ship_admin_shipment_log.left_at, line_id: @ship_admin_shipment_log.line_id, prepared_at: @ship_admin_shipment_log.prepared_at, station_id: @ship_admin_shipment_log.station_id } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/admin/shipment_logs', action: 'show', id: @shipment_log.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/admin/shipment_logs', action: 'edit', id: @shipment_log.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/admin/shipment_logs', action: 'update', id: @shipment_log.id),
      params: { shipment_log: { arrived_at: @ship_admin_shipment_log.arrived_at, expected_leave_at: @ship_admin_shipment_log.expected_leave_at, left_at: @ship_admin_shipment_log.left_at, line_id: @ship_admin_shipment_log.line_id, prepared_at: @ship_admin_shipment_log.prepared_at, station_id: @ship_admin_shipment_log.station_id } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('ShipmentLog.count', -1) do
      delete url_for(controller: 'ship/admin/shipment_logs', action: 'destroy', id: @shipment_log.id), as: :turbo_stream
    end

    assert_response :success
  end

end
