require "application_system_test_case"

class ContrasTest < ApplicationSystemTestCase
  setup do
    @contra = contras(:one)
  end

  test "visiting the index" do
    visit contras_url
    assert_selector "h1", text: "Contras"
  end

  test "creating a Contra" do
    visit contras_url
    click_on "New Contra"

    fill_in "Amount", with: @contra.amount
    fill_in "Date", with: @contra.date
    fill_in "Notes", with: @contra.notes
    click_on "Create Contra"

    assert_text "Contra was successfully created"
    click_on "Back"
  end

  test "updating a Contra" do
    visit contras_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @contra.amount
    fill_in "Date", with: @contra.date
    fill_in "Notes", with: @contra.notes
    click_on "Update Contra"

    assert_text "Contra was successfully updated"
    click_on "Back"
  end

  test "destroying a Contra" do
    visit contras_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contra was successfully destroyed"
  end
end
