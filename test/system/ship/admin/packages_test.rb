require "application_system_test_case"

class PackagesTest < ApplicationSystemTestCase
  setup do
    @ship_admin_package = ship_admin_packages(:one)
  end

  test "visiting the index" do
    visit ship_admin_packages_url
    assert_selector "h1", text: "Packages"
  end

  test "creating a Package" do
    visit ship_admin_packages_url
    click_on "New Package"

    fill_in "Address", with: @ship_admin_package.address
    fill_in "Expected on", with: @ship_admin_package.expected_on
    fill_in "Item", with: @ship_admin_package.item
    fill_in "State", with: @ship_admin_package.state
    click_on "Create Package"

    assert_text "Package was successfully created"
    click_on "Back"
  end

  test "updating a Package" do
    visit ship_admin_packages_url
    click_on "Edit", match: :first

    fill_in "Address", with: @ship_admin_package.address
    fill_in "Expected on", with: @ship_admin_package.expected_on
    fill_in "Item", with: @ship_admin_package.item
    fill_in "State", with: @ship_admin_package.state
    click_on "Update Package"

    assert_text "Package was successfully updated"
    click_on "Back"
  end

  test "destroying a Package" do
    visit ship_admin_packages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Package was successfully destroyed"
  end
end
