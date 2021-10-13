require 'test_helper'

class BrokeragesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brokerage = brokerages(:one)
  end

  test "should get index" do
    get brokerages_url
    assert_response :success
  end

  test "should get new" do
    get new_brokerage_url
    assert_response :success
  end

  test "should create brokerage" do
    assert_difference('Brokerage.count') do
      post brokerages_url, params: { brokerage: { amount: @brokerage.amount, broker_id: @brokerage.broker_id, cheque_number: @brokerage.cheque_number, notes: @brokerage.notes, payment_mode: @brokerage.payment_mode } }
    end

    assert_redirected_to brokerage_url(Brokerage.last)
  end

  test "should show brokerage" do
    get brokerage_url(@brokerage)
    assert_response :success
  end

  test "should get edit" do
    get edit_brokerage_url(@brokerage)
    assert_response :success
  end

  test "should update brokerage" do
    patch brokerage_url(@brokerage), params: { brokerage: { amount: @brokerage.amount, broker_id: @brokerage.broker_id, cheque_number: @brokerage.cheque_number, notes: @brokerage.notes, payment_mode: @brokerage.payment_mode } }
    assert_redirected_to brokerage_url(@brokerage)
  end

  test "should destroy brokerage" do
    assert_difference('Brokerage.count', -1) do
      delete brokerage_url(@brokerage)
    end

    assert_redirected_to brokerages_url
  end
end
