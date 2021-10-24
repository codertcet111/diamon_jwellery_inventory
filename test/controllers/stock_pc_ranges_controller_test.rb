require 'test_helper'

class StockPcRangesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stock_pc_range = stock_pc_ranges(:one)
  end

  test "should get index" do
    get stock_pc_ranges_url
    assert_response :success
  end

  test "should get new" do
    get new_stock_pc_range_url
    assert_response :success
  end

  test "should create stock_pc_range" do
    assert_difference('StockPcRange.count') do
      post stock_pc_ranges_url, params: { stock_pc_range: { max_value: @stock_pc_range.max_value, min_value: @stock_pc_range.min_value, name: @stock_pc_range.name } }
    end

    assert_redirected_to stock_pc_range_url(StockPcRange.last)
  end

  test "should show stock_pc_range" do
    get stock_pc_range_url(@stock_pc_range)
    assert_response :success
  end

  test "should get edit" do
    get edit_stock_pc_range_url(@stock_pc_range)
    assert_response :success
  end

  test "should update stock_pc_range" do
    patch stock_pc_range_url(@stock_pc_range), params: { stock_pc_range: { max_value: @stock_pc_range.max_value, min_value: @stock_pc_range.min_value, name: @stock_pc_range.name } }
    assert_redirected_to stock_pc_range_url(@stock_pc_range)
  end

  test "should destroy stock_pc_range" do
    assert_difference('StockPcRange.count', -1) do
      delete stock_pc_range_url(@stock_pc_range)
    end

    assert_redirected_to stock_pc_ranges_url
  end
end
