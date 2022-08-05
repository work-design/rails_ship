require "application_system_test_case"

class ShipmentLogsTest < ApplicationSystemTestCase
  setup do
    @ship_admin_shipment_log = ship_admin_shipment_logs(:one)
  end

  test "visiting the index" do
    visit ship_admin_shipment_logs_url
    assert_selector "h1", text: "Shipment logs"
  end

  test "should create shipment log" do
    visit ship_admin_shipment_logs_url
    click_on "New shipment log"

    fill_in "Arrived at", with: @ship_admin_shipment_log.arrived_at
    fill_in "Expected leave at", with: @ship_admin_shipment_log.expected_leave_at
    fill_in "Left at", with: @ship_admin_shipment_log.left_at
    fill_in "Line", with: @ship_admin_shipment_log.line_id
    fill_in "Prepared at", with: @ship_admin_shipment_log.prepared_at
    fill_in "Station", with: @ship_admin_shipment_log.station_id
    click_on "Create Shipment log"

    assert_text "Shipment log was successfully created"
    click_on "Back"
  end

  test "should update Shipment log" do
    visit ship_admin_shipment_log_url(@ship_admin_shipment_log)
    click_on "Edit this shipment log", match: :first

    fill_in "Arrived at", with: @ship_admin_shipment_log.arrived_at
    fill_in "Expected leave at", with: @ship_admin_shipment_log.expected_leave_at
    fill_in "Left at", with: @ship_admin_shipment_log.left_at
    fill_in "Line", with: @ship_admin_shipment_log.line_id
    fill_in "Prepared at", with: @ship_admin_shipment_log.prepared_at
    fill_in "Station", with: @ship_admin_shipment_log.station_id
    click_on "Update Shipment log"

    assert_text "Shipment log was successfully updated"
    click_on "Back"
  end

  test "should destroy Shipment log" do
    visit ship_admin_shipment_log_url(@ship_admin_shipment_log)
    click_on "Destroy this shipment log", match: :first

    assert_text "Shipment log was successfully destroyed"
  end
end
