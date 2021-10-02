require 'test_helper'

class StockTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stock_type = stock_types(:one)
  end

  test "should get index" do
    get stock_types_url
    assert_response :success
  end

  test "should get new" do
    get new_stock_type_url
    assert_response :success
  end

  test "should create stock_type" do
    assert_difference('StockType.count') do
      post stock_types_url, params: { stock_type: { name: @stock_type.name } }
    end

    assert_redirected_to stock_type_url(StockType.last)
  end

  test "should show stock_type" do
    get stock_type_url(@stock_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_stock_type_url(@stock_type)
    assert_response :success
  end

  test "should update stock_type" do
    patch stock_type_url(@stock_type), params: { stock_type: { name: @stock_type.name } }
    assert_redirected_to stock_type_url(@stock_type)
  end

  test "should destroy stock_type" do
    assert_difference('StockType.count', -1) do
      delete stock_type_url(@stock_type)
    end

    assert_redirected_to stock_types_url
  end
end
