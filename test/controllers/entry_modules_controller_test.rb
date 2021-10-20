require 'test_helper'

class EntryModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @entry_module = entry_modules(:one)
  end

  test "should get index" do
    get entry_modules_url
    assert_response :success
  end

  test "should get new" do
    get new_entry_module_url
    assert_response :success
  end

  test "should create entry_module" do
    assert_difference('EntryModule.count') do
      post entry_modules_url, params: { entry_module: { narration: @entry_module.narration, total_credit: @entry_module.total_credit, total_debit: @entry_module.total_debit } }
    end

    assert_redirected_to entry_module_url(EntryModule.last)
  end

  test "should show entry_module" do
    get entry_module_url(@entry_module)
    assert_response :success
  end

  test "should get edit" do
    get edit_entry_module_url(@entry_module)
    assert_response :success
  end

  test "should update entry_module" do
    patch entry_module_url(@entry_module), params: { entry_module: { narration: @entry_module.narration, total_credit: @entry_module.total_credit, total_debit: @entry_module.total_debit } }
    assert_redirected_to entry_module_url(@entry_module)
  end

  test "should destroy entry_module" do
    assert_difference('EntryModule.count', -1) do
      delete entry_module_url(@entry_module)
    end

    assert_redirected_to entry_modules_url
  end
end
