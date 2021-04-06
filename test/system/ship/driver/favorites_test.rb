require "application_system_test_case"

class FavoritesTest < ApplicationSystemTestCase
  setup do
    @ship_driver_favorite = ship_driver_favorites(:one)
  end

  test "visiting the index" do
    visit ship_driver_favorites_url
    assert_selector "h1", text: "Favorites"
  end

  test "creating a Favorite" do
    visit ship_driver_favorites_url
    click_on "New Favorite"

    fill_in "Avatar", with: @ship_driver_favorite.avatar
    fill_in "Name", with: @ship_driver_favorite.name
    click_on "Create Favorite"

    assert_text "Favorite was successfully created"
    click_on "Back"
  end

  test "updating a Favorite" do
    visit ship_driver_favorites_url
    click_on "Edit", match: :first

    fill_in "Avatar", with: @ship_driver_favorite.avatar
    fill_in "Name", with: @ship_driver_favorite.name
    click_on "Update Favorite"

    assert_text "Favorite was successfully updated"
    click_on "Back"
  end

  test "destroying a Favorite" do
    visit ship_driver_favorites_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Favorite was successfully destroyed"
  end
end
