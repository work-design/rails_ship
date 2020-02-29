require 'test_helper'
class Ship::Admin::PackagesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @ship_admin_package = create ship_admin_packages
  end

  test 'index ok' do
    get admin_packages_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_package_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Package.count') do
      post admin_packages_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_package_url(@ship_admin_package)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_package_url(@ship_admin_package)
    assert_response :success
  end

  test 'update ok' do
    patch admin_package_url(@ship_admin_package), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Package.count', -1) do
      delete admin_package_url(@ship_admin_package)
    end

    assert_response :success
  end

end
