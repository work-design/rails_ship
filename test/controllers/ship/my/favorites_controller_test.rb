require 'test_helper'
class Ship::My::FavoritesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @ship_my_favorite = create ship_my_favorites
  end

  test 'index ok' do
    get my_favorites_url
    assert_response :success
  end

  test 'new ok' do
    get new_my_favorite_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Favorite.count') do
      post my_favorites_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get my_favorite_url(@ship_my_favorite)
    assert_response :success
  end

  test 'edit ok' do
    get edit_my_favorite_url(@ship_my_favorite)
    assert_response :success
  end

  test 'update ok' do
    patch my_favorite_url(@ship_my_favorite), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Favorite.count', -1) do
      delete my_favorite_url(@ship_my_favorite)
    end

    assert_response :success
  end

end
