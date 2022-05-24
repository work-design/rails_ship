require "application_system_test_case"

class LinesTest < ApplicationSystemTestCase
  setup do
    @ship_admin_line = ship_admin_lines(:one)
  end

  test "visiting the index" do
    visit ship_admin_lines_url
    assert_selector "h1", text: "Lines"
  end

  test "should create line" do
    visit ship_admin_lines_url
    click_on "New line"

    fill_in "Finish name", with: @ship_admin_line.finish_name
    fill_in "Locations count", with: @ship_admin_line.locations_count
    fill_in "Name", with: @ship_admin_line.name
    fill_in "Start name", with: @ship_admin_line.start_name
    click_on "Create Line"

    assert_text "Line was successfully created"
    click_on "Back"
  end

  test "should update Line" do
    visit ship_admin_line_url(@ship_admin_line)
    click_on "Edit this line", match: :first

    fill_in "Finish name", with: @ship_admin_line.finish_name
    fill_in "Locations count", with: @ship_admin_line.locations_count
    fill_in "Name", with: @ship_admin_line.name
    fill_in "Start name", with: @ship_admin_line.start_name
    click_on "Update Line"

    assert_text "Line was successfully updated"
    click_on "Back"
  end

  test "should destroy Line" do
    visit ship_admin_line_url(@ship_admin_line)
    click_on "Destroy this line", match: :first

    assert_text "Line was successfully destroyed"
  end
end
