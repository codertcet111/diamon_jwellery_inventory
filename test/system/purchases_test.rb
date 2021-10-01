require "application_system_test_case"

class PurchasesTest < ApplicationSystemTestCase
  setup do
    @purchase = purchases(:one)
  end

  test "visiting the index" do
    visit purchases_url
    assert_selector "h1", text: "Purchases"
  end

  test "creating a Purchase" do
    visit purchases_url
    click_on "New Purchase"

    fill_in "Amount", with: @purchase.amount
    check "Bill present" if @purchase.bill_present
    fill_in "Days", with: @purchase.days
    fill_in "Dollar rate", with: @purchase.dollar_rate
    fill_in "Pending amount", with: @purchase.pending_amount
    fill_in "Purchase date", with: @purchase.purchase_date
    fill_in "Stock primary", with: @purchase.stock_primary_id
    click_on "Create Purchase"

    assert_text "Purchase was successfully created"
    click_on "Back"
  end

  test "updating a Purchase" do
    visit purchases_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @purchase.amount
    check "Bill present" if @purchase.bill_present
    fill_in "Days", with: @purchase.days
    fill_in "Dollar rate", with: @purchase.dollar_rate
    fill_in "Pending amount", with: @purchase.pending_amount
    fill_in "Purchase date", with: @purchase.purchase_date
    fill_in "Stock primary", with: @purchase.stock_primary_id
    click_on "Update Purchase"

    assert_text "Purchase was successfully updated"
    click_on "Back"
  end

  test "destroying a Purchase" do
    visit purchases_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Purchase was successfully destroyed"
  end
end
