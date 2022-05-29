require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  setup do
    @ship_admin_item = ship_admin_items(:one)
  end

  test "visiting the index" do
    visit ship_admin_items_url
    assert_selector "h1", text: "Items"
  end

  test "should create item" do
    visit ship_admin_items_url
    click_on "New item"

    fill_in "Package kind", with: @ship_admin_item.package_kind
    fill_in "Package name", with: @ship_admin_item.package_name
    fill_in "Package number", with: @ship_admin_item.package_number
    fill_in "Price", with: @ship_admin_item.price
    fill_in "Settle kind", with: @ship_admin_item.settle_kind
    fill_in "Settle period", with: @ship_admin_item.settle_period
    fill_in "Settle ratio", with: @ship_admin_item.settle_ratio
    fill_in "Volume", with: @ship_admin_item.volume
    fill_in "Volume unit", with: @ship_admin_item.volume_unit
    fill_in "Weight", with: @ship_admin_item.weight
    fill_in "Weight unit", with: @ship_admin_item.weight_unit
    click_on "Create Item"

    assert_text "Item was successfully created"
    click_on "Back"
  end

  test "should update Item" do
    visit ship_admin_item_url(@ship_admin_item)
    click_on "Edit this item", match: :first

    fill_in "Package kind", with: @ship_admin_item.package_kind
    fill_in "Package name", with: @ship_admin_item.package_name
    fill_in "Package number", with: @ship_admin_item.package_number
    fill_in "Price", with: @ship_admin_item.price
    fill_in "Settle kind", with: @ship_admin_item.settle_kind
    fill_in "Settle period", with: @ship_admin_item.settle_period
    fill_in "Settle ratio", with: @ship_admin_item.settle_ratio
    fill_in "Volume", with: @ship_admin_item.volume
    fill_in "Volume unit", with: @ship_admin_item.volume_unit
    fill_in "Weight", with: @ship_admin_item.weight
    fill_in "Weight unit", with: @ship_admin_item.weight_unit
    click_on "Update Item"

    assert_text "Item was successfully updated"
    click_on "Back"
  end

  test "should destroy Item" do
    visit ship_admin_item_url(@ship_admin_item)
    click_on "Destroy this item", match: :first

    assert_text "Item was successfully destroyed"
  end
end
