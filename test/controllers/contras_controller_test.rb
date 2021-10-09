require 'test_helper'

class ContrasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contra = contras(:one)
  end

  test "should get index" do
    get contras_url
    assert_response :success
  end

  test "should get new" do
    get new_contra_url
    assert_response :success
  end

  test "should create contra" do
    assert_difference('Contra.count') do
      post contras_url, params: { contra: { amount: @contra.amount, date: @contra.date, notes: @contra.notes } }
    end

    assert_redirected_to contra_url(Contra.last)
  end

  test "should show contra" do
    get contra_url(@contra)
    assert_response :success
  end

  test "should get edit" do
    get edit_contra_url(@contra)
    assert_response :success
  end

  test "should update contra" do
    patch contra_url(@contra), params: { contra: { amount: @contra.amount, date: @contra.date, notes: @contra.notes } }
    assert_redirected_to contra_url(@contra)
  end

  test "should destroy contra" do
    assert_difference('Contra.count', -1) do
      delete contra_url(@contra)
    end

    assert_redirected_to contras_url
  end
end
