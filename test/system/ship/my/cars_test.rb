require "application_system_test_case"

class CarsTest < ApplicationSystemTestCase
  setup do
    @ship_my_car = ship_my_cars(:one)
  end

  test "visiting the index" do
    visit ship_my_cars_url
    assert_selector "h1", text: "Cars"
  end

  test "creating a Car" do
    visit ship_my_cars_url
    click_on "New Car"

    fill_in "Location", with: @ship_my_car.location
    fill_in "Number", with: @ship_my_car.number
    fill_in "Registration", with: @ship_my_car.registration
    click_on "Create Car"

    assert_text "Car was successfully created"
    click_on "Back"
  end

  test "updating a Car" do
    visit ship_my_cars_url
    click_on "Edit", match: :first

    fill_in "Location", with: @ship_my_car.location
    fill_in "Number", with: @ship_my_car.number
    fill_in "Registration", with: @ship_my_car.registration
    click_on "Update Car"

    assert_text "Car was successfully updated"
    click_on "Back"
  end

  test "destroying a Car" do
    visit ship_my_cars_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Car was successfully destroyed"
  end
end
