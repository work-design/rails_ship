require "application_system_test_case"

class CarsTest < ApplicationSystemTestCase
  setup do
    @ship_admin_car = ship_admin_cars(:one)
  end

  test "visiting the index" do
    visit ship_admin_cars_url
    assert_selector "h1", text: "Cars"
  end

  test "should create car" do
    visit ship_admin_cars_url
    click_on "New car"

    fill_in "Detail", with: @ship_admin_car.detail
    fill_in "Location", with: @ship_admin_car.location
    fill_in "Member", with: @ship_admin_car.member_id
    fill_in "Number", with: @ship_admin_car.number
    fill_in "Registration", with: @ship_admin_car.registration
    fill_in "User", with: @ship_admin_car.user_id
    click_on "Create Car"

    assert_text "Car was successfully created"
    click_on "Back"
  end

  test "should update Car" do
    visit ship_admin_car_url(@ship_admin_car)
    click_on "Edit this car", match: :first

    fill_in "Detail", with: @ship_admin_car.detail
    fill_in "Location", with: @ship_admin_car.location
    fill_in "Member", with: @ship_admin_car.member_id
    fill_in "Number", with: @ship_admin_car.number
    fill_in "Registration", with: @ship_admin_car.registration
    fill_in "User", with: @ship_admin_car.user_id
    click_on "Update Car"

    assert_text "Car was successfully updated"
    click_on "Back"
  end

  test "should destroy Car" do
    visit ship_admin_car_url(@ship_admin_car)
    click_on "Destroy this car", match: :first

    assert_text "Car was successfully destroyed"
  end
end
