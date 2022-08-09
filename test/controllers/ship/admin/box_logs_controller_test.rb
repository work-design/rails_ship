require 'test_helper'
class Ship::Admin::BoxLogsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @box_log = box_logs(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/admin/box_logs')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/admin/box_logs')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('BoxLog.count') do
      post(
        url_for(controller: 'ship/admin/box_logs', action: 'create'),
        params: { box_log: { boxed_in_at: @ship_admin_box_log.boxed_in_at, boxed_out_at: @ship_admin_box_log.boxed_out_at, duration: @ship_admin_box_log.duration, package_id: @ship_admin_box_log.package_id } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/admin/box_logs', action: 'show', id: @box_log.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/admin/box_logs', action: 'edit', id: @box_log.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/admin/box_logs', action: 'update', id: @box_log.id),
      params: { box_log: { boxed_in_at: @ship_admin_box_log.boxed_in_at, boxed_out_at: @ship_admin_box_log.boxed_out_at, duration: @ship_admin_box_log.duration, package_id: @ship_admin_box_log.package_id } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('BoxLog.count', -1) do
      delete url_for(controller: 'ship/admin/box_logs', action: 'destroy', id: @box_log.id), as: :turbo_stream
    end

    assert_response :success
  end

end
