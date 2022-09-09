require "application_system_test_case"

class BoxSellsTest < ApplicationSystemTestCase
  setup do
    @ship_admin_box_sell = ship_admin_box_sells(:one)
  end

  test "visiting the index" do
    visit ship_admin_box_sells_url
    assert_selector "h1", text: "Box sells"
  end

  test "should create box sell" do
    visit ship_admin_box_sells_url
    click_on "New box sell"

    fill_in "Amount", with: @ship_admin_box_sell.amount
    fill_in "Done amount", with: @ship_admin_box_sell.done_amount
    fill_in "Member", with: @ship_admin_box_sell.member_id
    fill_in "Member organ", with: @ship_admin_box_sell.member_organ_id
    fill_in "Price", with: @ship_admin_box_sell.price
    fill_in "Rest amount", with: @ship_admin_box_sell.rest_amount
    fill_in "User", with: @ship_admin_box_sell.user_id
    click_on "Create Box sell"

    assert_text "Box sell was successfully created"
    click_on "Back"
  end

  test "should update Box sell" do
    visit ship_admin_box_sell_url(@ship_admin_box_sell)
    click_on "Edit this box sell", match: :first

    fill_in "Amount", with: @ship_admin_box_sell.amount
    fill_in "Done amount", with: @ship_admin_box_sell.done_amount
    fill_in "Member", with: @ship_admin_box_sell.member_id
    fill_in "Member organ", with: @ship_admin_box_sell.member_organ_id
    fill_in "Price", with: @ship_admin_box_sell.price
    fill_in "Rest amount", with: @ship_admin_box_sell.rest_amount
    fill_in "User", with: @ship_admin_box_sell.user_id
    click_on "Update Box sell"

    assert_text "Box sell was successfully updated"
    click_on "Back"
  end

  test "should destroy Box sell" do
    visit ship_admin_box_sell_url(@ship_admin_box_sell)
    click_on "Destroy this box sell", match: :first

    assert_text "Box sell was successfully destroyed"
  end
end
