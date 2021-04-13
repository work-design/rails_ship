require 'test_helper'
class Ship::Panel::LinesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @ship_panel_line = create ship_panel_lines
  end

  test 'index ok' do
    get panel_lines_url
    assert_response :success
  end

  test 'new ok' do
    get new_panel_line_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Line.count') do
      post panel_lines_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get panel_line_url(@ship_panel_line)
    assert_response :success
  end

  test 'edit ok' do
    get edit_panel_line_url(@ship_panel_line)
    assert_response :success
  end

  test 'update ok' do
    patch panel_line_url(@ship_panel_line), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Line.count', -1) do
      delete panel_line_url(@ship_panel_line)
    end

    assert_response :success
  end

end
