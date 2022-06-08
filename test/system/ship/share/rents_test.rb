require "application_system_test_case"

class RentsTest < ApplicationSystemTestCase
  setup do
    @ship_share_rent = ship_share_rents(:one)
  end

  test "visiting the index" do
    visit ship_share_rents_url
    assert_selector "h1", text: "Rents"
  end

  test "should create rent" do
    visit ship_share_rents_url
    click_on "New rent"

    fill_in "Estimate finish at", with: @ship_share_rent.estimate_finish_at
    fill_in "Finish at", with: @ship_share_rent.finish_at
    fill_in "Price", with: @ship_share_rent.price
    fill_in "Start at", with: @ship_share_rent.start_at
    click_on "Create Rent"

    assert_text "Rent was successfully created"
    click_on "Back"
  end

  test "should update Rent" do
    visit ship_share_rent_url(@ship_share_rent)
    click_on "Edit this rent", match: :first

    fill_in "Estimate finish at", with: @ship_share_rent.estimate_finish_at
    fill_in "Finish at", with: @ship_share_rent.finish_at
    fill_in "Price", with: @ship_share_rent.price
    fill_in "Start at", with: @ship_share_rent.start_at
    click_on "Update Rent"

    assert_text "Rent was successfully updated"
    click_on "Back"
  end

  test "should destroy Rent" do
    visit ship_share_rent_url(@ship_share_rent)
    click_on "Destroy this rent", match: :first

    assert_text "Rent was successfully destroyed"
  end
end
