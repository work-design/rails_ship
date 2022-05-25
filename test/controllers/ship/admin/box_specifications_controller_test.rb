require 'test_helper'
class Ship::Admin::BoxSpecificationsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @box_specification = box_specifications(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/admin/box_specifications')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/admin/box_specifications')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('BoxSpecification.count') do
      post(
        url_for(controller: 'ship/admin/box_specifications', action: 'create'),
        params: { box_specification: { height: @ship_admin_box_specification.height, length: @ship_admin_box_specification.length, name: @ship_admin_box_specification.name, width: @ship_admin_box_specification.width } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/admin/box_specifications', action: 'show', id: @box_specification.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/admin/box_specifications', action: 'edit', id: @box_specification.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/admin/box_specifications', action: 'update', id: @box_specification.id),
      params: { box_specification: { height: @ship_admin_box_specification.height, length: @ship_admin_box_specification.length, name: @ship_admin_box_specification.name, width: @ship_admin_box_specification.width } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('BoxSpecification.count', -1) do
      delete url_for(controller: 'ship/admin/box_specifications', action: 'destroy', id: @box_specification.id), as: :turbo_stream
    end

    assert_response :success
  end

end
