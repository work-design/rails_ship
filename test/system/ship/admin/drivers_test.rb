require "application_system_test_case"

class DriversTest < ApplicationSystemTestCase
  setup do
    @ship_admin_driver = ship_admin_drivers(:one)
  end

  test "visiting the index" do
    visit ship_admin_drivers_url
    assert_selector "h1", text: "Drivers"
  end

  test "should create driver" do
    visit ship_admin_drivers_url
    click_on "New driver"

    fill_in "Detail", with: @ship_admin_driver.detail
    fill_in "Name", with: @ship_admin_driver.name
    fill_in "Number", with: @ship_admin_driver.number
    fill_in "User", with: @ship_admin_driver.user_id
    click_on "Create Driver"

    assert_text "Driver was successfully created"
    click_on "Back"
  end

  test "should update Driver" do
    visit ship_admin_driver_url(@ship_admin_driver)
    click_on "Edit this driver", match: :first

    fill_in "Detail", with: @ship_admin_driver.detail
    fill_in "Name", with: @ship_admin_driver.name
    fill_in "Number", with: @ship_admin_driver.number
    fill_in "User", with: @ship_admin_driver.user_id
    click_on "Update Driver"

    assert_text "Driver was successfully updated"
    click_on "Back"
  end

  test "should destroy Driver" do
    visit ship_admin_driver_url(@ship_admin_driver)
    click_on "Destroy this driver", match: :first

    assert_text "Driver was successfully destroyed"
  end
end
