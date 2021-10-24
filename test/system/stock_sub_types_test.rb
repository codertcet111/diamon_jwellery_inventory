require "application_system_test_case"

class StockSubTypesTest < ApplicationSystemTestCase
  setup do
    @stock_sub_type = stock_sub_types(:one)
  end

  test "visiting the index" do
    visit stock_sub_types_url
    assert_selector "h1", text: "Stock Sub Types"
  end

  test "creating a Stock sub type" do
    visit stock_sub_types_url
    click_on "New Stock Sub Type"

    fill_in "Name", with: @stock_sub_type.name
    fill_in "Stock type", with: @stock_sub_type.stock_type_id
    fill_in "Weight unit", with: @stock_sub_type.weight_unit
    click_on "Create Stock sub type"

    assert_text "Stock sub type was successfully created"
    click_on "Back"
  end

  test "updating a Stock sub type" do
    visit stock_sub_types_url
    click_on "Edit", match: :first

    fill_in "Name", with: @stock_sub_type.name
    fill_in "Stock type", with: @stock_sub_type.stock_type_id
    fill_in "Weight unit", with: @stock_sub_type.weight_unit
    click_on "Update Stock sub type"

    assert_text "Stock sub type was successfully updated"
    click_on "Back"
  end

  test "destroying a Stock sub type" do
    visit stock_sub_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stock sub type was successfully destroyed"
  end
end
