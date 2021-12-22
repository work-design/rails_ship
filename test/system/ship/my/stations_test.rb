require "application_system_test_case"

class StationsTest < ApplicationSystemTestCase
  setup do
    @ship_my_station = ship_my_stations(:one)
  end

  test "visiting the index" do
    visit ship_my_stations_url
    assert_selector "h1", text: "Stations"
  end

  test "should create station" do
    visit ship_my_stations_url
    click_on "New station"

    fill_in "Area", with: @ship_my_station.area_id
    fill_in "Detail", with: @ship_my_station.detail
    fill_in "Name", with: @ship_my_station.name
    click_on "Create Station"

    assert_text "Station was successfully created"
    click_on "Back"
  end

  test "should update Station" do
    visit ship_my_station_url(@ship_my_station)
    click_on "Edit this station", match: :first

    fill_in "Area", with: @ship_my_station.area_id
    fill_in "Detail", with: @ship_my_station.detail
    fill_in "Name", with: @ship_my_station.name
    click_on "Update Station"

    assert_text "Station was successfully updated"
    click_on "Back"
  end

  test "should destroy Station" do
    visit ship_my_station_url(@ship_my_station)
    click_on "Destroy this station", match: :first

    assert_text "Station was successfully destroyed"
  end
end
