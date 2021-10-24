require "application_system_test_case"

class JournalVouchersTest < ApplicationSystemTestCase
  setup do
    @journal_voucher = journal_vouchers(:one)
  end

  test "visiting the index" do
    visit journal_vouchers_url
    assert_selector "h1", text: "Journal Vouchers"
  end

  test "creating a Journal voucher" do
    visit journal_vouchers_url
    click_on "New Journal Voucher"

    fill_in "Amount", with: @journal_voucher.amount
    fill_in "Date", with: @journal_voucher.date
    fill_in "Notes", with: @journal_voucher.notes
    click_on "Create Journal voucher"

    assert_text "Journal voucher was successfully created"
    click_on "Back"
  end

  test "updating a Journal voucher" do
    visit journal_vouchers_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @journal_voucher.amount
    fill_in "Date", with: @journal_voucher.date
    fill_in "Notes", with: @journal_voucher.notes
    click_on "Update Journal voucher"

    assert_text "Journal voucher was successfully updated"
    click_on "Back"
  end

  test "destroying a Journal voucher" do
    visit journal_vouchers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Journal voucher was successfully destroyed"
  end
end
