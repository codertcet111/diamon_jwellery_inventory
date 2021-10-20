require "application_system_test_case"

class EntryModulesTest < ApplicationSystemTestCase
  setup do
    @entry_module = entry_modules(:one)
  end

  test "visiting the index" do
    visit entry_modules_url
    assert_selector "h1", text: "Entry Modules"
  end

  test "creating a Entry module" do
    visit entry_modules_url
    click_on "New Entry Module"

    fill_in "Narration", with: @entry_module.narration
    fill_in "Total credit", with: @entry_module.total_credit
    fill_in "Total debit", with: @entry_module.total_debit
    click_on "Create Entry module"

    assert_text "Entry module was successfully created"
    click_on "Back"
  end

  test "updating a Entry module" do
    visit entry_modules_url
    click_on "Edit", match: :first

    fill_in "Narration", with: @entry_module.narration
    fill_in "Total credit", with: @entry_module.total_credit
    fill_in "Total debit", with: @entry_module.total_debit
    click_on "Update Entry module"

    assert_text "Entry module was successfully updated"
    click_on "Back"
  end

  test "destroying a Entry module" do
    visit entry_modules_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Entry module was successfully destroyed"
  end
end
