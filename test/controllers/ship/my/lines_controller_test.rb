require 'test_helper'
class Ship::My::LinesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @ship_my_line = create ship_my_lines
  end

  test 'index ok' do
    get my_lines_url
    assert_response :success
  end

  test 'new ok' do
    get new_my_line_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Line.count') do
      post my_lines_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get my_line_url(@ship_my_line)
    assert_response :success
  end

  test 'edit ok' do
    get edit_my_line_url(@ship_my_line)
    assert_response :success
  end

  test 'update ok' do
    patch my_line_url(@ship_my_line), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Line.count', -1) do
      delete my_line_url(@ship_my_line)
    end

    assert_response :success
  end

end
