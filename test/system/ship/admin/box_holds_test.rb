require "application_system_test_case"

class BoxHoldsTest < ApplicationSystemTestCase
  setup do
    @ship_admin_box_hold = ship_admin_box_holds(:one)
  end

  test "visiting the index" do
    visit ship_admin_box_holds_url
    assert_selector "h1", text: "Box holds"
  end

  test "should create box hold" do
    visit ship_admin_box_holds_url
    click_on "New box hold"

    fill_in "Boxes count", with: @ship_admin_box_hold.boxes_count
    fill_in "Buyable", with: @ship_admin_box_hold.buyable
    fill_in "Member", with: @ship_admin_box_hold.member_id
    fill_in "Member organ", with: @ship_admin_box_hold.member_organ_id
    fill_in "Sellable", with: @ship_admin_box_hold.sellable
    fill_in "User", with: @ship_admin_box_hold.user_id
    click_on "Create Box hold"

    assert_text "Box hold was successfully created"
    click_on "Back"
  end

  test "should update Box hold" do
    visit ship_admin_box_hold_url(@ship_admin_box_hold)
    click_on "Edit this box hold", match: :first

    fill_in "Boxes count", with: @ship_admin_box_hold.boxes_count
    fill_in "Buyable", with: @ship_admin_box_hold.buyable
    fill_in "Member", with: @ship_admin_box_hold.member_id
    fill_in "Member organ", with: @ship_admin_box_hold.member_organ_id
    fill_in "Sellable", with: @ship_admin_box_hold.sellable
    fill_in "User", with: @ship_admin_box_hold.user_id
    click_on "Update Box hold"

    assert_text "Box hold was successfully updated"
    click_on "Back"
  end

  test "should destroy Box hold" do
    visit ship_admin_box_hold_url(@ship_admin_box_hold)
    click_on "Destroy this box hold", match: :first

    assert_text "Box hold was successfully destroyed"
  end
end
