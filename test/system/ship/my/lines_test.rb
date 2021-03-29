require "application_system_test_case"

class LinesTest < ApplicationSystemTestCase
  setup do
    @ship_my_line = ship_my_lines(:one)
  end

  test "visiting the index" do
    visit ship_my_lines_url
    assert_selector "h1", text: "Lines"
  end

  test "creating a Line" do
    visit ship_my_lines_url
    click_on "New Line"

    fill_in "Finish name", with: @ship_my_line.finish_name
    fill_in "Start name", with: @ship_my_line.start_name
    click_on "Create Line"

    assert_text "Line was successfully created"
    click_on "Back"
  end

  test "updating a Line" do
    visit ship_my_lines_url
    click_on "Edit", match: :first

    fill_in "Finish name", with: @ship_my_line.finish_name
    fill_in "Start name", with: @ship_my_line.start_name
    click_on "Update Line"

    assert_text "Line was successfully updated"
    click_on "Back"
  end

  test "destroying a Line" do
    visit ship_my_lines_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Line was successfully destroyed"
  end
end
