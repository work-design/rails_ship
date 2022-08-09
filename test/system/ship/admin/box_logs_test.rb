require "application_system_test_case"

class BoxLogsTest < ApplicationSystemTestCase
  setup do
    @ship_admin_box_log = ship_admin_box_logs(:one)
  end

  test "visiting the index" do
    visit ship_admin_box_logs_url
    assert_selector "h1", text: "Box logs"
  end

  test "should create box log" do
    visit ship_admin_box_logs_url
    click_on "New box log"

    fill_in "Boxed in at", with: @ship_admin_box_log.boxed_in_at
    fill_in "Boxed out at", with: @ship_admin_box_log.boxed_out_at
    fill_in "Duration", with: @ship_admin_box_log.duration
    fill_in "Package", with: @ship_admin_box_log.package_id
    click_on "Create Box log"

    assert_text "Box log was successfully created"
    click_on "Back"
  end

  test "should update Box log" do
    visit ship_admin_box_log_url(@ship_admin_box_log)
    click_on "Edit this box log", match: :first

    fill_in "Boxed in at", with: @ship_admin_box_log.boxed_in_at
    fill_in "Boxed out at", with: @ship_admin_box_log.boxed_out_at
    fill_in "Duration", with: @ship_admin_box_log.duration
    fill_in "Package", with: @ship_admin_box_log.package_id
    click_on "Update Box log"

    assert_text "Box log was successfully updated"
    click_on "Back"
  end

  test "should destroy Box log" do
    visit ship_admin_box_log_url(@ship_admin_box_log)
    click_on "Destroy this box log", match: :first

    assert_text "Box log was successfully destroyed"
  end
end
