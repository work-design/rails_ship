require 'test_helper'
class Ship::My::BoxSellsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @box_sell = box_sells(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/my/box_sells')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/my/box_sells')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('BoxSell.count') do
      post(
        url_for(controller: 'ship/my/box_sells', action: 'create'),
        params: { box_sell: { amount: @ship_my_box_sell.amount, box_specification_id: @ship_my_box_sell.box_specification_id, price: @ship_my_box_sell.price } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/my/box_sells', action: 'show', id: @box_sell.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/my/box_sells', action: 'edit', id: @box_sell.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/my/box_sells', action: 'update', id: @box_sell.id),
      params: { box_sell: { amount: @ship_my_box_sell.amount, box_specification_id: @ship_my_box_sell.box_specification_id, price: @ship_my_box_sell.price } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('BoxSell.count', -1) do
      delete url_for(controller: 'ship/my/box_sells', action: 'destroy', id: @box_sell.id), as: :turbo_stream
    end

    assert_response :success
  end

end
