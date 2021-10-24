require "application_system_test_case"

class StockTypesTest < ApplicationSystemTestCase
  setup do
    @stock_type = stock_types(:one)
  end

  test "visiting the index" do
    visit stock_types_url
    assert_selector "h1", text: "Stock Types"
  end

  test "creating a Stock type" do
    visit stock_types_url
    click_on "New Stock Type"

    fill_in "Name", with: @stock_type.name
    click_on "Create Stock type"

    assert_text "Stock type was successfully created"
    click_on "Back"
  end

  test "updating a Stock type" do
    visit stock_types_url
    click_on "Edit", match: :first

    fill_in "Name", with: @stock_type.name
    click_on "Update Stock type"

    assert_text "Stock type was successfully updated"
    click_on "Back"
  end

  test "destroying a Stock type" do
    visit stock_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stock type was successfully destroyed"
  end
end
