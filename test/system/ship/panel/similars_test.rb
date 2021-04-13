require "application_system_test_case"

class SimilarsTest < ApplicationSystemTestCase
  setup do
    @ship_panel_similar = ship_panel_similars(:one)
  end

  test "visiting the index" do
    visit ship_panel_similars_url
    assert_selector "h1", text: "Similars"
  end

  test "creating a Similar" do
    visit ship_panel_similars_url
    click_on "New Similar"

    fill_in "Finish name", with: @ship_panel_similar.finish_name
    fill_in "Name", with: @ship_panel_similar.name
    fill_in "Start name", with: @ship_panel_similar.start_name
    click_on "Create Similar"

    assert_text "Similar was successfully created"
    click_on "Back"
  end

  test "updating a Similar" do
    visit ship_panel_similars_url
    click_on "Edit", match: :first

    fill_in "Finish name", with: @ship_panel_similar.finish_name
    fill_in "Name", with: @ship_panel_similar.name
    fill_in "Start name", with: @ship_panel_similar.start_name
    click_on "Update Similar"

    assert_text "Similar was successfully updated"
    click_on "Back"
  end

  test "destroying a Similar" do
    visit ship_panel_similars_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Similar was successfully destroyed"
  end
end
