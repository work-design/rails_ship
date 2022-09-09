require 'test_helper'
class Ship::Admin::BoxProxySellsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @box_proxy_sell = box_proxy_sells(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/admin/box_proxy_sells')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/admin/box_proxy_sells')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('BoxProxySell.count') do
      post(
        url_for(controller: 'ship/admin/box_proxy_sells', action: 'create'),
        params: { box_proxy_sell: { price: @ship_admin_box_proxy_sell.price, sellable_count: @ship_admin_box_proxy_sell.sellable_count } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/admin/box_proxy_sells', action: 'show', id: @box_proxy_sell.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/admin/box_proxy_sells', action: 'edit', id: @box_proxy_sell.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/admin/box_proxy_sells', action: 'update', id: @box_proxy_sell.id),
      params: { box_proxy_sell: { price: @ship_admin_box_proxy_sell.price, sellable_count: @ship_admin_box_proxy_sell.sellable_count } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('BoxProxySell.count', -1) do
      delete url_for(controller: 'ship/admin/box_proxy_sells', action: 'destroy', id: @box_proxy_sell.id), as: :turbo_stream
    end

    assert_response :success
  end

end
