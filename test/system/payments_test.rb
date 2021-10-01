require "application_system_test_case"

class PaymentsTest < ApplicationSystemTestCase
  setup do
    @payment = payments(:one)
  end

  test "visiting the index" do
    visit payments_url
    assert_selector "h1", text: "Payments"
  end

  test "creating a Payment" do
    visit payments_url
    click_on "New Payment"

    fill_in "Amount", with: @payment.amount
    fill_in "Date", with: @payment.date
    fill_in "Notes", with: @payment.notes
    fill_in "Party", with: @payment.party
    fill_in "Party come", with: @payment.party_come
    fill_in "Party paid", with: @payment.party_paid
    fill_in "Payment mode", with: @payment.payment_mode
    fill_in "Pc acc name", with: @payment.pc_acc_name
    fill_in "Pp acc name", with: @payment.pp_acc_name
    fill_in "Purchase", with: @payment.purchase
    click_on "Create Payment"

    assert_text "Payment was successfully created"
    click_on "Back"
  end

  test "updating a Payment" do
    visit payments_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @payment.amount
    fill_in "Date", with: @payment.date
    fill_in "Notes", with: @payment.notes
    fill_in "Party", with: @payment.party
    fill_in "Party come", with: @payment.party_come
    fill_in "Party paid", with: @payment.party_paid
    fill_in "Payment mode", with: @payment.payment_mode
    fill_in "Pc acc name", with: @payment.pc_acc_name
    fill_in "Pp acc name", with: @payment.pp_acc_name
    fill_in "Purchase", with: @payment.purchase
    click_on "Update Payment"

    assert_text "Payment was successfully updated"
    click_on "Back"
  end

  test "destroying a Payment" do
    visit payments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Payment was successfully destroyed"
  end
end
