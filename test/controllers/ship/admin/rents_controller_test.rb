require 'test_helper'
class Ship::Admin::RentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @rent = rents(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/admin/rents')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/admin/rents')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Rent.count') do
      post(
        url_for(controller: 'ship/admin/rents', action: 'create'),
        params: { rent: { duration: @ship_admin_rent.duration, estimate_finish_at: @ship_admin_rent.estimate_finish_at, finish_at: @ship_admin_rent.finish_at, item_id: @ship_admin_rent.item_id, member_id: @ship_admin_rent.member_id, member_organ_id: @ship_admin_rent.member_organ_id, start_at: @ship_admin_rent.start_at, user_id: @ship_admin_rent.user_id } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/admin/rents', action: 'show', id: @rent.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/admin/rents', action: 'edit', id: @rent.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/admin/rents', action: 'update', id: @rent.id),
      params: { rent: { duration: @ship_admin_rent.duration, estimate_finish_at: @ship_admin_rent.estimate_finish_at, finish_at: @ship_admin_rent.finish_at, item_id: @ship_admin_rent.item_id, member_id: @ship_admin_rent.member_id, member_organ_id: @ship_admin_rent.member_organ_id, start_at: @ship_admin_rent.start_at, user_id: @ship_admin_rent.user_id } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Rent.count', -1) do
      delete url_for(controller: 'ship/admin/rents', action: 'destroy', id: @rent.id), as: :turbo_stream
    end

    assert_response :success
  end

end
