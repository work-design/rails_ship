require "application_system_test_case"

class RalliesTest < ApplicationSystemTestCase
  setup do
    @ship_my_rally = ship_my_rallies(:one)
  end

  test "visiting the index" do
    visit ship_my_rallies_url
    assert_selector "h1", text: "Rallies"
  end

  test "creating a Rally" do
    visit ship_my_rallies_url
    click_on "New Rally"

    fill_in "Area", with: @ship_my_rally.area_id
    fill_in "Detail", with: @ship_my_rally.detail
    fill_in "Name", with: @ship_my_rally.name
    click_on "Create Rally"

    assert_text "Rally was successfully created"
    click_on "Back"
  end

  test "updating a Rally" do
    visit ship_my_rallies_url
    click_on "Edit", match: :first

    fill_in "Area", with: @ship_my_rally.area_id
    fill_in "Detail", with: @ship_my_rally.detail
    fill_in "Name", with: @ship_my_rally.name
    click_on "Update Rally"

    assert_text "Rally was successfully updated"
    click_on "Back"
  end

  test "destroying a Rally" do
    visit ship_my_rallies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rally was successfully destroyed"
  end
end
