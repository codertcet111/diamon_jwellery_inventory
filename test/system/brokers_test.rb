require "application_system_test_case"

class BrokersTest < ApplicationSystemTestCase
  setup do
    @broker = brokers(:one)
  end

  test "visiting the index" do
    visit brokers_url
    assert_selector "h1", text: "Brokers"
  end

  test "creating a Broker" do
    visit brokers_url
    click_on "New Broker"

    fill_in "Address", with: @broker.address
    fill_in "Adhaar no", with: @broker.adhaar_no
    fill_in "Gst no", with: @broker.gst_no
    fill_in "Mobile", with: @broker.mobile
    fill_in "Mobile 2", with: @broker.mobile_2
    fill_in "Name", with: @broker.name
    fill_in "Pan no", with: @broker.pan_no
    fill_in "Qbc", with: @broker.qbc
    fill_in "Refrence 1", with: @broker.refrence_1
    fill_in "Refrence 2", with: @broker.refrence_2
    fill_in "Refrence 3", with: @broker.refrence_3
    click_on "Create Broker"

    assert_text "Broker was successfully created"
    click_on "Back"
  end

  test "updating a Broker" do
    visit brokers_url
    click_on "Edit", match: :first

    fill_in "Address", with: @broker.address
    fill_in "Adhaar no", with: @broker.adhaar_no
    fill_in "Gst no", with: @broker.gst_no
    fill_in "Mobile", with: @broker.mobile
    fill_in "Mobile 2", with: @broker.mobile_2
    fill_in "Name", with: @broker.name
    fill_in "Pan no", with: @broker.pan_no
    fill_in "Qbc", with: @broker.qbc
    fill_in "Refrence 1", with: @broker.refrence_1
    fill_in "Refrence 2", with: @broker.refrence_2
    fill_in "Refrence 3", with: @broker.refrence_3
    click_on "Update Broker"

    assert_text "Broker was successfully updated"
    click_on "Back"
  end

  test "destroying a Broker" do
    visit brokers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Broker was successfully destroyed"
  end
end
