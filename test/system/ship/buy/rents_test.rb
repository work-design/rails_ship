require "application_system_test_case"

class RentsTest < ApplicationSystemTestCase
  setup do
    @ship_buy_rent = ship_buy_rents(:one)
  end

  test "visiting the index" do
    visit ship_buy_rents_url
    assert_selector "h1", text: "Rents"
  end

  test "should create rent" do
    visit ship_buy_rents_url
    click_on "New rent"

    fill_in "Estimate finish at", with: @ship_buy_rent.estimate_finish_at
    fill_in "Finish at", with: @ship_buy_rent.finish_at
    fill_in "Price", with: @ship_buy_rent.price
    fill_in "Rentable", with: @ship_buy_rent.rentable
    fill_in "Start at", with: @ship_buy_rent.start_at
    click_on "Create Rent"

    assert_text "Rent was successfully created"
    click_on "Back"
  end

  test "should update Rent" do
    visit ship_buy_rent_url(@ship_buy_rent)
    click_on "Edit this rent", match: :first

    fill_in "Estimate finish at", with: @ship_buy_rent.estimate_finish_at
    fill_in "Finish at", with: @ship_buy_rent.finish_at
    fill_in "Price", with: @ship_buy_rent.price
    fill_in "Rentable", with: @ship_buy_rent.rentable
    fill_in "Start at", with: @ship_buy_rent.start_at
    click_on "Update Rent"

    assert_text "Rent was successfully updated"
    click_on "Back"
  end

  test "should destroy Rent" do
    visit ship_buy_rent_url(@ship_buy_rent)
    click_on "Destroy this rent", match: :first

    assert_text "Rent was successfully destroyed"
  end
end
