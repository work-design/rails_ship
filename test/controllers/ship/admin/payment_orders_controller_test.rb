require 'test_helper'
class Ship::Admin::PaymentOrdersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @payment_order = payment_orders(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/admin/payment_orders')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/admin/payment_orders')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('PaymentOrder.count') do
      post(
        url_for(controller: 'ship/admin/payment_orders', action: 'create'),
        params: { payment_order: { check_amount: @ship_admin_payment_order.check_amount, order_id: @ship_admin_payment_order.order_id, state: @ship_admin_payment_order.state, user_id: @ship_admin_payment_order.user_id } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/admin/payment_orders', action: 'show', id: @payment_order.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/admin/payment_orders', action: 'edit', id: @payment_order.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/admin/payment_orders', action: 'update', id: @payment_order.id),
      params: { payment_order: { check_amount: @ship_admin_payment_order.check_amount, order_id: @ship_admin_payment_order.order_id, state: @ship_admin_payment_order.state, user_id: @ship_admin_payment_order.user_id } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('PaymentOrder.count', -1) do
      delete url_for(controller: 'ship/admin/payment_orders', action: 'destroy', id: @payment_order.id), as: :turbo_stream
    end

    assert_response :success
  end

end
