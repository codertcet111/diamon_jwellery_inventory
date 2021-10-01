require "application_system_test_case"

class PartiesTest < ApplicationSystemTestCase
  setup do
    @party = parties(:one)
  end

  test "visiting the index" do
    visit parties_url
    assert_selector "h1", text: "Parties"
  end

  test "creating a Party" do
    visit parties_url
    click_on "New Party"

    fill_in "Address", with: @party.address
    fill_in "Adhaar no", with: @party.adhaar_no
    fill_in "Gst no", with: @party.gst_no
    fill_in "Mobile", with: @party.mobile
    fill_in "Mobile 2", with: @party.mobile_2
    fill_in "Name", with: @party.name
    fill_in "Pan no", with: @party.pan_no
    fill_in "Qbc", with: @party.qbc
    fill_in "Refrence 1", with: @party.refrence_1
    fill_in "Refrence 2", with: @party.refrence_2
    fill_in "Refrence 3", with: @party.refrence_3
    click_on "Create Party"

    assert_text "Party was successfully created"
    click_on "Back"
  end

  test "updating a Party" do
    visit parties_url
    click_on "Edit", match: :first

    fill_in "Address", with: @party.address
    fill_in "Adhaar no", with: @party.adhaar_no
    fill_in "Gst no", with: @party.gst_no
    fill_in "Mobile", with: @party.mobile
    fill_in "Mobile 2", with: @party.mobile_2
    fill_in "Name", with: @party.name
    fill_in "Pan no", with: @party.pan_no
    fill_in "Qbc", with: @party.qbc
    fill_in "Refrence 1", with: @party.refrence_1
    fill_in "Refrence 2", with: @party.refrence_2
    fill_in "Refrence 3", with: @party.refrence_3
    click_on "Update Party"

    assert_text "Party was successfully updated"
    click_on "Back"
  end

  test "destroying a Party" do
    visit parties_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Party was successfully destroyed"
  end
end
