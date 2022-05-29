require "application_system_test_case"

class ShipmentsTest < ApplicationSystemTestCase
  setup do
    @ship_admin_shipment = ship_admin_shipments(:one)
  end

  test "visiting the index" do
    visit ship_admin_shipments_url
    assert_selector "h1", text: "Shipments"
  end

  test "should create shipment" do
    visit ship_admin_shipments_url
    click_on "New shipment"

    fill_in "Arrived at", with: @ship_admin_shipment.arrived_at
    fill_in "Car", with: @ship_admin_shipment.car_id
    fill_in "Driver id]", with: @ship_admin_shipment.driver_id]
    fill_in "Left at", with: @ship_admin_shipment.left_at
    fill_in "Line", with: @ship_admin_shipment.line_id
    fill_in "Load on", with: @ship_admin_shipment.load_on
    fill_in "State", with: @ship_admin_shipment.state
    click_on "Create Shipment"

    assert_text "Shipment was successfully created"
    click_on "Back"
  end

  test "should update Shipment" do
    visit ship_admin_shipment_url(@ship_admin_shipment)
    click_on "Edit this shipment", match: :first

    fill_in "Arrived at", with: @ship_admin_shipment.arrived_at
    fill_in "Car", with: @ship_admin_shipment.car_id
    fill_in "Driver id]", with: @ship_admin_shipment.driver_id]
    fill_in "Left at", with: @ship_admin_shipment.left_at
    fill_in "Line", with: @ship_admin_shipment.line_id
    fill_in "Load on", with: @ship_admin_shipment.load_on
    fill_in "State", with: @ship_admin_shipment.state
    click_on "Update Shipment"

    assert_text "Shipment was successfully updated"
    click_on "Back"
  end

  test "should destroy Shipment" do
    visit ship_admin_shipment_url(@ship_admin_shipment)
    click_on "Destroy this shipment", match: :first

    assert_text "Shipment was successfully destroyed"
  end
end
