require "application_system_test_case"

class BoxSpecificationsTest < ApplicationSystemTestCase
  setup do
    @ship_admin_box_specification = ship_admin_box_specifications(:one)
  end

  test "visiting the index" do
    visit ship_admin_box_specifications_url
    assert_selector "h1", text: "Box specifications"
  end

  test "should create box specification" do
    visit ship_admin_box_specifications_url
    click_on "New box specification"

    fill_in "Height", with: @ship_admin_box_specification.height
    fill_in "Length", with: @ship_admin_box_specification.length
    fill_in "Name", with: @ship_admin_box_specification.name
    fill_in "Width", with: @ship_admin_box_specification.width
    click_on "Create Box specification"

    assert_text "Box specification was successfully created"
    click_on "Back"
  end

  test "should update Box specification" do
    visit ship_admin_box_specification_url(@ship_admin_box_specification)
    click_on "Edit this box specification", match: :first

    fill_in "Height", with: @ship_admin_box_specification.height
    fill_in "Length", with: @ship_admin_box_specification.length
    fill_in "Name", with: @ship_admin_box_specification.name
    fill_in "Width", with: @ship_admin_box_specification.width
    click_on "Update Box specification"

    assert_text "Box specification was successfully updated"
    click_on "Back"
  end

  test "should destroy Box specification" do
    visit ship_admin_box_specification_url(@ship_admin_box_specification)
    click_on "Destroy this box specification", match: :first

    assert_text "Box specification was successfully destroyed"
  end
end
