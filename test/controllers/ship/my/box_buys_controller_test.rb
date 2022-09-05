require 'test_helper'
class Ship::My::BoxBuysControllerTest < ActionDispatch::IntegrationTest

  setup do
    @box_buy = box_buys(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/my/box_buys')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/my/box_buys')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('BoxBuy.count') do
      post(
        url_for(controller: 'ship/my/box_buys', action: 'create'),
        params: { box_buy: { amount: @ship_my_box_buy.amount, box_specification_id: @ship_my_box_buy.box_specification_id, price: @ship_my_box_buy.price } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/my/box_buys', action: 'show', id: @box_buy.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/my/box_buys', action: 'edit', id: @box_buy.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/my/box_buys', action: 'update', id: @box_buy.id),
      params: { box_buy: { amount: @ship_my_box_buy.amount, box_specification_id: @ship_my_box_buy.box_specification_id, price: @ship_my_box_buy.price } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('BoxBuy.count', -1) do
      delete url_for(controller: 'ship/my/box_buys', action: 'destroy', id: @box_buy.id), as: :turbo_stream
    end

    assert_response :success
  end

end
