require 'test_helper'
class Ship::Admin::LinesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @line = lines(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/admin/lines')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/admin/lines')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Line.count') do
      post(
        url_for(controller: 'ship/admin/lines', action: 'create'),
        params: { line: { finish_name: @ship_admin_line.finish_name, locations_count: @ship_admin_line.locations_count, name: @ship_admin_line.name, start_name: @ship_admin_line.start_name } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/admin/lines', action: 'show', id: @line.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/admin/lines', action: 'edit', id: @line.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/admin/lines', action: 'update', id: @line.id),
      params: { line: { finish_name: @ship_admin_line.finish_name, locations_count: @ship_admin_line.locations_count, name: @ship_admin_line.name, start_name: @ship_admin_line.start_name } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Line.count', -1) do
      delete url_for(controller: 'ship/admin/lines', action: 'destroy', id: @line.id), as: :turbo_stream
    end

    assert_response :success
  end

end
