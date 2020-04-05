require 'test_helper'
class Ship::Admin::PackagesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @package = create :packages
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
      post admin_packages_url, params: {}
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_package_url(@package)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_package_url(@package)
    assert_response :success
  end

  test 'update ok' do
    patch admin_package_url(@package), params: {  }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Package.count', -1) do
      delete admin_package_url(@package)
    end

    assert_response :success
  end

end
