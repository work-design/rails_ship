require 'test_helper'
class Ship::Admin::LocationsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @location = locations(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/admin/locations')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/admin/locations')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Location.count') do
      post(
        url_for(controller: 'ship/admin/locations', action: 'create'),
        params: { location: { cityname: @ship_admin_location.cityname, lat: @ship_admin_location.lat, lng: @ship_admin_location.lng, name: @ship_admin_location.name, poiaddress: @ship_admin_location.poiaddress, poiname: @ship_admin_location.poiname } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/admin/locations', action: 'show', id: @location.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/admin/locations', action: 'edit', id: @location.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/admin/locations', action: 'update', id: @location.id),
      params: { location: { cityname: @ship_admin_location.cityname, lat: @ship_admin_location.lat, lng: @ship_admin_location.lng, name: @ship_admin_location.name, poiaddress: @ship_admin_location.poiaddress, poiname: @ship_admin_location.poiname } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Location.count', -1) do
      delete url_for(controller: 'ship/admin/locations', action: 'destroy', id: @location.id), as: :turbo_stream
    end

    assert_response :success
  end

end
