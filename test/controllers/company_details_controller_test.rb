require 'test_helper'

class CompanyDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company_detail = company_details(:one)
  end

  test "should get index" do
    get company_details_url
    assert_response :success
  end

  test "should get new" do
    get new_company_detail_url
    assert_response :success
  end

  test "should create company_detail" do
    assert_difference('CompanyDetail.count') do
      post company_details_url, params: { company_detail: { address: @company_detail.address, adhaar: @company_detail.adhaar, gst: @company_detail.gst, mobile_number: @company_detail.mobile_number, name: @company_detail.name, pan_card: @company_detail.pan_card, qbc_no: @company_detail.qbc_no } }
    end

    assert_redirected_to company_detail_url(CompanyDetail.last)
  end

  test "should show company_detail" do
    get company_detail_url(@company_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_company_detail_url(@company_detail)
    assert_response :success
  end

  test "should update company_detail" do
    patch company_detail_url(@company_detail), params: { company_detail: { address: @company_detail.address, adhaar: @company_detail.adhaar, gst: @company_detail.gst, mobile_number: @company_detail.mobile_number, name: @company_detail.name, pan_card: @company_detail.pan_card, qbc_no: @company_detail.qbc_no } }
    assert_redirected_to company_detail_url(@company_detail)
  end

  test "should destroy company_detail" do
    assert_difference('CompanyDetail.count', -1) do
      delete company_detail_url(@company_detail)
    end

    assert_redirected_to company_details_url
  end
end
