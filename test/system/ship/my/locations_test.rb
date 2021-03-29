require "application_system_test_case"

class LocationsTest < ApplicationSystemTestCase
  setup do
    @ship_my_location = ship_my_locations(:one)
  end

  test "visiting the index" do
    visit ship_my_locations_url
    assert_selector "h1", text: "Locations"
  end

  test "creating a Location" do
    visit ship_my_locations_url
    click_on "New Location"

    fill_in "Cityname", with: @ship_my_location.cityname
    fill_in "Lat", with: @ship_my_location.lat
    fill_in "Lng", with: @ship_my_location.lng
    fill_in "Poiaddress", with: @ship_my_location.poiaddress
    fill_in "Poiname", with: @ship_my_location.poiname
    click_on "Create Location"

    assert_text "Location was successfully created"
    click_on "Back"
  end

  test "updating a Location" do
    visit ship_my_locations_url
    click_on "Edit", match: :first

    fill_in "Cityname", with: @ship_my_location.cityname
    fill_in "Lat", with: @ship_my_location.lat
    fill_in "Lng", with: @ship_my_location.lng
    fill_in "Poiaddress", with: @ship_my_location.poiaddress
    fill_in "Poiname", with: @ship_my_location.poiname
    click_on "Update Location"

    assert_text "Location was successfully updated"
    click_on "Back"
  end

  test "destroying a Location" do
    visit ship_my_locations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Location was successfully destroyed"
  end
end
