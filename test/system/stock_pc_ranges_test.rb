require "application_system_test_case"

class StockPcRangesTest < ApplicationSystemTestCase
  setup do
    @stock_pc_range = stock_pc_ranges(:one)
  end

  test "visiting the index" do
    visit stock_pc_ranges_url
    assert_selector "h1", text: "Stock Pc Ranges"
  end

  test "creating a Stock pc range" do
    visit stock_pc_ranges_url
    click_on "New Stock Pc Range"

    fill_in "Max value", with: @stock_pc_range.max_value
    fill_in "Min value", with: @stock_pc_range.min_value
    fill_in "Name", with: @stock_pc_range.name
    click_on "Create Stock pc range"

    assert_text "Stock pc range was successfully created"
    click_on "Back"
  end

  test "updating a Stock pc range" do
    visit stock_pc_ranges_url
    click_on "Edit", match: :first

    fill_in "Max value", with: @stock_pc_range.max_value
    fill_in "Min value", with: @stock_pc_range.min_value
    fill_in "Name", with: @stock_pc_range.name
    click_on "Update Stock pc range"

    assert_text "Stock pc range was successfully updated"
    click_on "Back"
  end

  test "destroying a Stock pc range" do
    visit stock_pc_ranges_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stock pc range was successfully destroyed"
  end
end
