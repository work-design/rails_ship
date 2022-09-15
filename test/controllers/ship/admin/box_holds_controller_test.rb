require 'test_helper'
class Ship::Admin::BoxHoldsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @box_hold = box_holds(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/admin/box_holds')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/admin/box_holds')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('BoxHold.count') do
      post(
        url_for(controller: 'ship/admin/box_holds', action: 'create'),
        params: { box_hold: { boxes_count: @ship_admin_box_hold.boxes_count, buyable: @ship_admin_box_hold.buyable, member_id: @ship_admin_box_hold.member_id, member_organ_id: @ship_admin_box_hold.member_organ_id, sellable: @ship_admin_box_hold.sellable, user_id: @ship_admin_box_hold.user_id } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/admin/box_holds', action: 'show', id: @box_hold.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/admin/box_holds', action: 'edit', id: @box_hold.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/admin/box_holds', action: 'update', id: @box_hold.id),
      params: { box_hold: { boxes_count: @ship_admin_box_hold.boxes_count, buyable: @ship_admin_box_hold.buyable, member_id: @ship_admin_box_hold.member_id, member_organ_id: @ship_admin_box_hold.member_organ_id, sellable: @ship_admin_box_hold.sellable, user_id: @ship_admin_box_hold.user_id } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('BoxHold.count', -1) do
      delete url_for(controller: 'ship/admin/box_holds', action: 'destroy', id: @box_hold.id), as: :turbo_stream
    end

    assert_response :success
  end

end
