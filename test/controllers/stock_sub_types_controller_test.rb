require 'test_helper'

class StockSubTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stock_sub_type = stock_sub_types(:one)
  end

  test "should get index" do
    get stock_sub_types_url
    assert_response :success
  end

  test "should get new" do
    get new_stock_sub_type_url
    assert_response :success
  end

  test "should create stock_sub_type" do
    assert_difference('StockSubType.count') do
      post stock_sub_types_url, params: { stock_sub_type: { name: @stock_sub_type.name, stock_type_id: @stock_sub_type.stock_type_id, weight_unit: @stock_sub_type.weight_unit } }
    end

    assert_redirected_to stock_sub_type_url(StockSubType.last)
  end

  test "should show stock_sub_type" do
    get stock_sub_type_url(@stock_sub_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_stock_sub_type_url(@stock_sub_type)
    assert_response :success
  end

  test "should update stock_sub_type" do
    patch stock_sub_type_url(@stock_sub_type), params: { stock_sub_type: { name: @stock_sub_type.name, stock_type_id: @stock_sub_type.stock_type_id, weight_unit: @stock_sub_type.weight_unit } }
    assert_redirected_to stock_sub_type_url(@stock_sub_type)
  end

  test "should destroy stock_sub_type" do
    assert_difference('StockSubType.count', -1) do
      delete stock_sub_type_url(@stock_sub_type)
    end

    assert_redirected_to stock_sub_types_url
  end
end
