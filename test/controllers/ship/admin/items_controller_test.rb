require 'test_helper'
class Ship::Admin::ItemsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @item = items(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/admin/items')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/admin/items')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Item.count') do
      post(
        url_for(controller: 'ship/admin/items', action: 'create'),
        params: { item: { package_kind: @ship_admin_item.package_kind, package_name: @ship_admin_item.package_name, package_number: @ship_admin_item.package_number, price: @ship_admin_item.price, settle_kind: @ship_admin_item.settle_kind, settle_period: @ship_admin_item.settle_period, settle_ratio: @ship_admin_item.settle_ratio, volume: @ship_admin_item.volume, volume_unit: @ship_admin_item.volume_unit, weight: @ship_admin_item.weight, weight_unit: @ship_admin_item.weight_unit } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/admin/items', action: 'show', id: @item.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/admin/items', action: 'edit', id: @item.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/admin/items', action: 'update', id: @item.id),
      params: { item: { package_kind: @ship_admin_item.package_kind, package_name: @ship_admin_item.package_name, package_number: @ship_admin_item.package_number, price: @ship_admin_item.price, settle_kind: @ship_admin_item.settle_kind, settle_period: @ship_admin_item.settle_period, settle_ratio: @ship_admin_item.settle_ratio, volume: @ship_admin_item.volume, volume_unit: @ship_admin_item.volume_unit, weight: @ship_admin_item.weight, weight_unit: @ship_admin_item.weight_unit } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Item.count', -1) do
      delete url_for(controller: 'ship/admin/items', action: 'destroy', id: @item.id), as: :turbo_stream
    end

    assert_response :success
  end

end
