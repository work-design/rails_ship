require "application_system_test_case"

class RentsTest < ApplicationSystemTestCase
  setup do
    @ship_admin_rent = ship_admin_rents(:one)
  end

  test "visiting the index" do
    visit ship_admin_rents_url
    assert_selector "h1", text: "Rents"
  end

  test "should create rent" do
    visit ship_admin_rents_url
    click_on "New rent"

    fill_in "Duration", with: @ship_admin_rent.duration
    fill_in "Estimate finish at", with: @ship_admin_rent.estimate_finish_at
    fill_in "Finish at", with: @ship_admin_rent.finish_at
    fill_in "Item", with: @ship_admin_rent.item_id
    fill_in "Member", with: @ship_admin_rent.member_id
    fill_in "Member organ", with: @ship_admin_rent.member_organ_id
    fill_in "Start at", with: @ship_admin_rent.start_at
    fill_in "User", with: @ship_admin_rent.user_id
    click_on "Create Rent"

    assert_text "Rent was successfully created"
    click_on "Back"
  end

  test "should update Rent" do
    visit ship_admin_rent_url(@ship_admin_rent)
    click_on "Edit this rent", match: :first

    fill_in "Duration", with: @ship_admin_rent.duration
    fill_in "Estimate finish at", with: @ship_admin_rent.estimate_finish_at
    fill_in "Finish at", with: @ship_admin_rent.finish_at
    fill_in "Item", with: @ship_admin_rent.item_id
    fill_in "Member", with: @ship_admin_rent.member_id
    fill_in "Member organ", with: @ship_admin_rent.member_organ_id
    fill_in "Start at", with: @ship_admin_rent.start_at
    fill_in "User", with: @ship_admin_rent.user_id
    click_on "Update Rent"

    assert_text "Rent was successfully updated"
    click_on "Back"
  end

  test "should destroy Rent" do
    visit ship_admin_rent_url(@ship_admin_rent)
    click_on "Destroy this rent", match: :first

    assert_text "Rent was successfully destroyed"
  end
end
