require "application_system_test_case"

class LocationsTest < ApplicationSystemTestCase
  setup do
    @ship_admin_location = ship_admin_locations(:one)
  end

  test "visiting the index" do
    visit ship_admin_locations_url
    assert_selector "h1", text: "Locations"
  end

  test "should create location" do
    visit ship_admin_locations_url
    click_on "New location"

    fill_in "Cityname", with: @ship_admin_location.cityname
    fill_in "Lat", with: @ship_admin_location.lat
    fill_in "Lng", with: @ship_admin_location.lng
    fill_in "Name", with: @ship_admin_location.name
    fill_in "Poiaddress", with: @ship_admin_location.poiaddress
    fill_in "Poiname", with: @ship_admin_location.poiname
    click_on "Create Location"

    assert_text "Location was successfully created"
    click_on "Back"
  end

  test "should update Location" do
    visit ship_admin_location_url(@ship_admin_location)
    click_on "Edit this location", match: :first

    fill_in "Cityname", with: @ship_admin_location.cityname
    fill_in "Lat", with: @ship_admin_location.lat
    fill_in "Lng", with: @ship_admin_location.lng
    fill_in "Name", with: @ship_admin_location.name
    fill_in "Poiaddress", with: @ship_admin_location.poiaddress
    fill_in "Poiname", with: @ship_admin_location.poiname
    click_on "Update Location"

    assert_text "Location was successfully updated"
    click_on "Back"
  end

  test "should destroy Location" do
    visit ship_admin_location_url(@ship_admin_location)
    click_on "Destroy this location", match: :first

    assert_text "Location was successfully destroyed"
  end
end
