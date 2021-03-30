require "application_system_test_case"

class DriversTest < ApplicationSystemTestCase
  setup do
    @ship_my_driver = ship_my_drivers(:one)
  end

  test "visiting the index" do
    visit ship_my_drivers_url
    assert_selector "h1", text: "Drivers"
  end

  test "creating a Driver" do
    visit ship_my_drivers_url
    click_on "New Driver"

    fill_in "License", with: @ship_my_driver.license
    fill_in "Name", with: @ship_my_driver.name
    fill_in "Number", with: @ship_my_driver.number
    click_on "Create Driver"

    assert_text "Driver was successfully created"
    click_on "Back"
  end

  test "updating a Driver" do
    visit ship_my_drivers_url
    click_on "Edit", match: :first

    fill_in "License", with: @ship_my_driver.license
    fill_in "Name", with: @ship_my_driver.name
    fill_in "Number", with: @ship_my_driver.number
    click_on "Update Driver"

    assert_text "Driver was successfully updated"
    click_on "Back"
  end

  test "destroying a Driver" do
    visit ship_my_drivers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Driver was successfully destroyed"
  end
end
