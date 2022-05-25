require "application_system_test_case"

class BoxesTest < ApplicationSystemTestCase
  setup do
    @ship_admin_box = ship_admin_boxes(:one)
  end

  test "visiting the index" do
    visit ship_admin_boxes_url
    assert_selector "h1", text: "Boxes"
  end

  test "should create box" do
    visit ship_admin_boxes_url
    click_on "New box"

    fill_in "Box specification", with: @ship_admin_box.box_specification_id
    fill_in "Code", with: @ship_admin_box.code
    fill_in "Status", with: @ship_admin_box.status
    click_on "Create Box"

    assert_text "Box was successfully created"
    click_on "Back"
  end

  test "should update Box" do
    visit ship_admin_box_url(@ship_admin_box)
    click_on "Edit this box", match: :first

    fill_in "Box specification", with: @ship_admin_box.box_specification_id
    fill_in "Code", with: @ship_admin_box.code
    fill_in "Status", with: @ship_admin_box.status
    click_on "Update Box"

    assert_text "Box was successfully updated"
    click_on "Back"
  end

  test "should destroy Box" do
    visit ship_admin_box_url(@ship_admin_box)
    click_on "Destroy this box", match: :first

    assert_text "Box was successfully destroyed"
  end
end
