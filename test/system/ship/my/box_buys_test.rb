require "application_system_test_case"

class BoxBuysTest < ApplicationSystemTestCase
  setup do
    @ship_my_box_buy = ship_my_box_buys(:one)
  end

  test "visiting the index" do
    visit ship_my_box_buys_url
    assert_selector "h1", text: "Box buys"
  end

  test "should create box buy" do
    visit ship_my_box_buys_url
    click_on "New box buy"

    fill_in "Amount", with: @ship_my_box_buy.amount
    fill_in "Box specification", with: @ship_my_box_buy.box_specification_id
    fill_in "Price", with: @ship_my_box_buy.price
    click_on "Create Box buy"

    assert_text "Box buy was successfully created"
    click_on "Back"
  end

  test "should update Box buy" do
    visit ship_my_box_buy_url(@ship_my_box_buy)
    click_on "Edit this box buy", match: :first

    fill_in "Amount", with: @ship_my_box_buy.amount
    fill_in "Box specification", with: @ship_my_box_buy.box_specification_id
    fill_in "Price", with: @ship_my_box_buy.price
    click_on "Update Box buy"

    assert_text "Box buy was successfully updated"
    click_on "Back"
  end

  test "should destroy Box buy" do
    visit ship_my_box_buy_url(@ship_my_box_buy)
    click_on "Destroy this box buy", match: :first

    assert_text "Box buy was successfully destroyed"
  end
end
