require 'test_helper'
class Ship::Admin::BoxesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @box = boxes(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/admin/boxes')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/admin/boxes')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Box.count') do
      post(
        url_for(controller: 'ship/admin/boxes', action: 'create'),
        params: { box: { box_specification_id: @ship_admin_box.box_specification_id, code: @ship_admin_box.code, status: @ship_admin_box.status } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/admin/boxes', action: 'show', id: @box.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/admin/boxes', action: 'edit', id: @box.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/admin/boxes', action: 'update', id: @box.id),
      params: { box: { box_specification_id: @ship_admin_box.box_specification_id, code: @ship_admin_box.code, status: @ship_admin_box.status } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Box.count', -1) do
      delete url_for(controller: 'ship/admin/boxes', action: 'destroy', id: @box.id), as: :turbo_stream
    end

    assert_response :success
  end

end
