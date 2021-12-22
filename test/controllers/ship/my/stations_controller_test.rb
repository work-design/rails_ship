require 'test_helper'
class Ship::My::StationsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @station = stations(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/my/stations')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/my/stations')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Station.count') do
      post(
        url_for(controller: 'ship/my/stations', action: 'create'),
        params: { station: { area_id: @ship_my_station.area_id, detail: @ship_my_station.detail, name: @ship_my_station.name } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/my/stations', action: 'show', id: @station.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/my/stations', action: 'edit', id: @station.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/my/stations', action: 'update', id: @station.id),
      params: { station: { area_id: @ship_my_station.area_id, detail: @ship_my_station.detail, name: @ship_my_station.name } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Station.count', -1) do
      delete url_for(controller: 'ship/my/stations', action: 'destroy', id: @station.id), as: :turbo_stream
    end

    assert_response :success
  end

end
