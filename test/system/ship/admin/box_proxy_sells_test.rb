require "application_system_test_case"

class BoxProxySellsTest < ApplicationSystemTestCase
  setup do
    @ship_admin_box_proxy_sell = ship_admin_box_proxy_sells(:one)
  end

  test "visiting the index" do
    visit ship_admin_box_proxy_sells_url
    assert_selector "h1", text: "Box proxy sells"
  end

  test "should create box proxy sell" do
    visit ship_admin_box_proxy_sells_url
    click_on "New box proxy sell"

    fill_in "Price", with: @ship_admin_box_proxy_sell.price
    fill_in "Sellable count", with: @ship_admin_box_proxy_sell.sellable_count
    click_on "Create Box proxy sell"

    assert_text "Box proxy sell was successfully created"
    click_on "Back"
  end

  test "should update Box proxy sell" do
    visit ship_admin_box_proxy_sell_url(@ship_admin_box_proxy_sell)
    click_on "Edit this box proxy sell", match: :first

    fill_in "Price", with: @ship_admin_box_proxy_sell.price
    fill_in "Sellable count", with: @ship_admin_box_proxy_sell.sellable_count
    click_on "Update Box proxy sell"

    assert_text "Box proxy sell was successfully updated"
    click_on "Back"
  end

  test "should destroy Box proxy sell" do
    visit ship_admin_box_proxy_sell_url(@ship_admin_box_proxy_sell)
    click_on "Destroy this box proxy sell", match: :first

    assert_text "Box proxy sell was successfully destroyed"
  end
end
