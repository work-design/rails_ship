require 'test_helper'
class Ship::BoxProxyBuysControllerTest < ActionDispatch::IntegrationTest

  setup do
    @box_proxy_buy = box_proxy_buys(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/box_proxy_buys')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/box_proxy_buys')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('BoxProxyBuy.count') do
      post(
        url_for(controller: 'ship/box_proxy_buys', action: 'create'),
        params: { box_proxy_buy: { buyable_count: @ship_box_proxy_buy.buyable_count, price: @ship_box_proxy_buy.price } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/box_proxy_buys', action: 'show', id: @box_proxy_buy.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/box_proxy_buys', action: 'edit', id: @box_proxy_buy.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/box_proxy_buys', action: 'update', id: @box_proxy_buy.id),
      params: { box_proxy_buy: { buyable_count: @ship_box_proxy_buy.buyable_count, price: @ship_box_proxy_buy.price } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('BoxProxyBuy.count', -1) do
      delete url_for(controller: 'ship/box_proxy_buys', action: 'destroy', id: @box_proxy_buy.id), as: :turbo_stream
    end

    assert_response :success
  end

end
