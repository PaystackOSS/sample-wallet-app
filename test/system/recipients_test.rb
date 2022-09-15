require "application_system_test_case"

class RecipientsTest < ApplicationSystemTestCase
  setup do
    @recipient = recipients(:one)
  end

  test "visiting the index" do
    visit recipients_url
    assert_selector "h1", text: "Recipients"
  end

  test "should create recipient" do
    visit recipients_url
    click_on "New recipient"

    click_on "Create Recipient"

    assert_text "Recipient was successfully created"
    click_on "Back"
  end

  test "should update Recipient" do
    visit recipient_url(@recipient)
    click_on "Edit this recipient", match: :first

    click_on "Update Recipient"

    assert_text "Recipient was successfully updated"
    click_on "Back"
  end

  test "should destroy Recipient" do
    visit recipient_url(@recipient)
    click_on "Destroy this recipient", match: :first

    assert_text "Recipient was successfully destroyed"
  end
end
