require 'test_helper'

class JournalVouchersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @journal_voucher = journal_vouchers(:one)
  end

  test "should get index" do
    get journal_vouchers_url
    assert_response :success
  end

  test "should get new" do
    get new_journal_voucher_url
    assert_response :success
  end

  test "should create journal_voucher" do
    assert_difference('JournalVoucher.count') do
      post journal_vouchers_url, params: { journal_voucher: { amount: @journal_voucher.amount, date: @journal_voucher.date, notes: @journal_voucher.notes } }
    end

    assert_redirected_to journal_voucher_url(JournalVoucher.last)
  end

  test "should show journal_voucher" do
    get journal_voucher_url(@journal_voucher)
    assert_response :success
  end

  test "should get edit" do
    get edit_journal_voucher_url(@journal_voucher)
    assert_response :success
  end

  test "should update journal_voucher" do
    patch journal_voucher_url(@journal_voucher), params: { journal_voucher: { amount: @journal_voucher.amount, date: @journal_voucher.date, notes: @journal_voucher.notes } }
    assert_redirected_to journal_voucher_url(@journal_voucher)
  end

  test "should destroy journal_voucher" do
    assert_difference('JournalVoucher.count', -1) do
      delete journal_voucher_url(@journal_voucher)
    end

    assert_redirected_to journal_vouchers_url
  end
end
