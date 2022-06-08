require 'test_helper'
class Ship::Share::RentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @rent = rents(:one)
  end

  test 'index ok' do
    get url_for(controller: 'ship/share/rents')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'ship/share/rents')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('Rent.count') do
      post(
        url_for(controller: 'ship/share/rents', action: 'create'),
        params: { rent: { estimate_finish_at: @ship_share_rent.estimate_finish_at, finish_at: @ship_share_rent.finish_at, price: @ship_share_rent.price, start_at: @ship_share_rent.start_at } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'ship/share/rents', action: 'show', id: @rent.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'ship/share/rents', action: 'edit', id: @rent.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'ship/share/rents', action: 'update', id: @rent.id),
      params: { rent: { estimate_finish_at: @ship_share_rent.estimate_finish_at, finish_at: @ship_share_rent.finish_at, price: @ship_share_rent.price, start_at: @ship_share_rent.start_at } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Rent.count', -1) do
      delete url_for(controller: 'ship/share/rents', action: 'destroy', id: @rent.id), as: :turbo_stream
    end

    assert_response :success
  end

end
