require "application_system_test_case"

class BoxProxyBuysTest < ApplicationSystemTestCase
  setup do
    @ship_box_proxy_buy = ship_box_proxy_buys(:one)
  end

  test "visiting the index" do
    visit ship_box_proxy_buys_url
    assert_selector "h1", text: "Box proxy buys"
  end

  test "should create box proxy buy" do
    visit ship_box_proxy_buys_url
    click_on "New box proxy buy"

    fill_in "Buyable count", with: @ship_box_proxy_buy.buyable_count
    fill_in "Price", with: @ship_box_proxy_buy.price
    click_on "Create Box proxy buy"

    assert_text "Box proxy buy was successfully created"
    click_on "Back"
  end

  test "should update Box proxy buy" do
    visit ship_box_proxy_buy_url(@ship_box_proxy_buy)
    click_on "Edit this box proxy buy", match: :first

    fill_in "Buyable count", with: @ship_box_proxy_buy.buyable_count
    fill_in "Price", with: @ship_box_proxy_buy.price
    click_on "Update Box proxy buy"

    assert_text "Box proxy buy was successfully updated"
    click_on "Back"
  end

  test "should destroy Box proxy buy" do
    visit ship_box_proxy_buy_url(@ship_box_proxy_buy)
    click_on "Destroy this box proxy buy", match: :first

    assert_text "Box proxy buy was successfully destroyed"
  end
end
