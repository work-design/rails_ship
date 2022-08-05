require "application_system_test_case"

class PaymentOrdersTest < ApplicationSystemTestCase
  setup do
    @ship_admin_payment_order = ship_admin_payment_orders(:one)
  end

  test "visiting the index" do
    visit ship_admin_payment_orders_url
    assert_selector "h1", text: "Payment orders"
  end

  test "should create payment order" do
    visit ship_admin_payment_orders_url
    click_on "New payment order"

    fill_in "Check amount", with: @ship_admin_payment_order.check_amount
    fill_in "Order", with: @ship_admin_payment_order.order_id
    fill_in "State", with: @ship_admin_payment_order.state
    fill_in "User", with: @ship_admin_payment_order.user_id
    click_on "Create Payment order"

    assert_text "Payment order was successfully created"
    click_on "Back"
  end

  test "should update Payment order" do
    visit ship_admin_payment_order_url(@ship_admin_payment_order)
    click_on "Edit this payment order", match: :first

    fill_in "Check amount", with: @ship_admin_payment_order.check_amount
    fill_in "Order", with: @ship_admin_payment_order.order_id
    fill_in "State", with: @ship_admin_payment_order.state
    fill_in "User", with: @ship_admin_payment_order.user_id
    click_on "Update Payment order"

    assert_text "Payment order was successfully updated"
    click_on "Back"
  end

  test "should destroy Payment order" do
    visit ship_admin_payment_order_url(@ship_admin_payment_order)
    click_on "Destroy this payment order", match: :first

    assert_text "Payment order was successfully destroyed"
  end
end
