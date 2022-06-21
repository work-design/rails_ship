require 'test_helper'
class Ship::Admin::ShipmentItemsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @shipment_item = shipment_items(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/admin/shipment_items')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/admin/shipment_items')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('ShipmentItem.count') do
      post(
        url_for(controller: 'ship/admin/shipment_items', action: 'create'),
        params: { shipment_item: { box_id: @ship_admin_shipment_item.box_id, loaded_at: @ship_admin_shipment_item.loaded_at, package_id: @ship_admin_shipment_item.package_id, state: @ship_admin_shipment_item.state, status: @ship_admin_shipment_item.status, unloaded_at: @ship_admin_shipment_item.unloaded_at } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/admin/shipment_items', action: 'show', id: @shipment_item.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/admin/shipment_items', action: 'edit', id: @shipment_item.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/admin/shipment_items', action: 'update', id: @shipment_item.id),
      params: { shipment_item: { box_id: @ship_admin_shipment_item.box_id, loaded_at: @ship_admin_shipment_item.loaded_at, package_id: @ship_admin_shipment_item.package_id, state: @ship_admin_shipment_item.state, status: @ship_admin_shipment_item.status, unloaded_at: @ship_admin_shipment_item.unloaded_at } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('ShipmentItem.count', -1) do
      delete url_for(controller: 'ship/admin/shipment_items', action: 'destroy', id: @shipment_item.id), as: :turbo_stream
    end

    assert_response :success
  end

end
