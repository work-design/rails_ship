require 'test_helper'
class Ship::Driver::FavoritesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @ship_driver_favorite = create ship_driver_favorites
  end

  test 'index ok' do
    get driver_favorites_url
    assert_response :success
  end

  test 'new ok' do
    get new_driver_favorite_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Favorite.count') do
      post driver_favorites_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get driver_favorite_url(@ship_driver_favorite)
    assert_response :success
  end

  test 'edit ok' do
    get edit_driver_favorite_url(@ship_driver_favorite)
    assert_response :success
  end

  test 'update ok' do
    patch driver_favorite_url(@ship_driver_favorite), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Favorite.count', -1) do
      delete driver_favorite_url(@ship_driver_favorite)
    end

    assert_response :success
  end

end
