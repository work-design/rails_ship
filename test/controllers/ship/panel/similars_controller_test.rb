require 'test_helper'
class Ship::Panel::SimilarsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @ship_panel_similar = create ship_panel_similars
  end

  test 'index ok' do
    get panel_similars_url
    assert_response :success
  end

  test 'new ok' do
    get new_panel_similar_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Similar.count') do
      post panel_similars_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get panel_similar_url(@ship_panel_similar)
    assert_response :success
  end

  test 'edit ok' do
    get edit_panel_similar_url(@ship_panel_similar)
    assert_response :success
  end

  test 'update ok' do
    patch panel_similar_url(@ship_panel_similar), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Similar.count', -1) do
      delete panel_similar_url(@ship_panel_similar)
    end

    assert_response :success
  end

end
