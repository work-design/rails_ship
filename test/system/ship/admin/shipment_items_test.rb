require "application_system_test_case"

class ShipmentItemsTest < ApplicationSystemTestCase
  setup do
    @ship_admin_shipment_item = ship_admin_shipment_items(:one)
  end

  test "visiting the index" do
    visit ship_admin_shipment_items_url
    assert_selector "h1", text: "Shipment items"
  end

  test "should create shipment item" do
    visit ship_admin_shipment_items_url
    click_on "New shipment item"

    fill_in "Box", with: @ship_admin_shipment_item.box_id
    fill_in "Loaded at", with: @ship_admin_shipment_item.loaded_at
    fill_in "Package", with: @ship_admin_shipment_item.package_id
    fill_in "State", with: @ship_admin_shipment_item.state
    fill_in "Status", with: @ship_admin_shipment_item.status
    fill_in "Unloaded at", with: @ship_admin_shipment_item.unloaded_at
    click_on "Create Shipment item"

    assert_text "Shipment item was successfully created"
    click_on "Back"
  end

  test "should update Shipment item" do
    visit ship_admin_shipment_item_url(@ship_admin_shipment_item)
    click_on "Edit this shipment item", match: :first

    fill_in "Box", with: @ship_admin_shipment_item.box_id
    fill_in "Loaded at", with: @ship_admin_shipment_item.loaded_at
    fill_in "Package", with: @ship_admin_shipment_item.package_id
    fill_in "State", with: @ship_admin_shipment_item.state
    fill_in "Status", with: @ship_admin_shipment_item.status
    fill_in "Unloaded at", with: @ship_admin_shipment_item.unloaded_at
    click_on "Update Shipment item"

    assert_text "Shipment item was successfully updated"
    click_on "Back"
  end

  test "should destroy Shipment item" do
    visit ship_admin_shipment_item_url(@ship_admin_shipment_item)
    click_on "Destroy this shipment item", match: :first

    assert_text "Shipment item was successfully destroyed"
  end
end
