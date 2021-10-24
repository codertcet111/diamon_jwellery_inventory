require "application_system_test_case"

class BrokeragesTest < ApplicationSystemTestCase
  setup do
    @brokerage = brokerages(:one)
  end

  test "visiting the index" do
    visit brokerages_url
    assert_selector "h1", text: "Brokerages"
  end

  test "creating a Brokerage" do
    visit brokerages_url
    click_on "New Brokerage"

    fill_in "Amount", with: @brokerage.amount
    fill_in "Broker", with: @brokerage.broker_id
    fill_in "Cheque number", with: @brokerage.cheque_number
    fill_in "Notes", with: @brokerage.notes
    fill_in "Payment mode", with: @brokerage.payment_mode
    click_on "Create Brokerage"

    assert_text "Brokerage was successfully created"
    click_on "Back"
  end

  test "updating a Brokerage" do
    visit brokerages_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @brokerage.amount
    fill_in "Broker", with: @brokerage.broker_id
    fill_in "Cheque number", with: @brokerage.cheque_number
    fill_in "Notes", with: @brokerage.notes
    fill_in "Payment mode", with: @brokerage.payment_mode
    click_on "Update Brokerage"

    assert_text "Brokerage was successfully updated"
    click_on "Back"
  end

  test "destroying a Brokerage" do
    visit brokerages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Brokerage was successfully destroyed"
  end
end
