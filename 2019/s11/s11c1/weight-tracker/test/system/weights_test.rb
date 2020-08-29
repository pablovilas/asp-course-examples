require "application_system_test_case"

class WeightsTest < ApplicationSystemTestCase
  setup do
    @weight = weights(:one)
  end

  test "visiting the index" do
    visit weights_url
    assert_selector "h1", text: "Weights"
  end

  test "creating a Weight" do
    visit weights_url
    click_on "New Weight"

    fill_in "Sample date", with: @weight.sample_date
    fill_in "Value", with: @weight.value
    click_on "Create Weight"

    assert_text "Weight was successfully created"
    click_on "Back"
  end

  test "updating a Weight" do
    visit weights_url
    click_on "Edit", match: :first

    fill_in "Sample date", with: @weight.sample_date
    fill_in "Value", with: @weight.value
    click_on "Update Weight"

    assert_text "Weight was successfully updated"
    click_on "Back"
  end

  test "destroying a Weight" do
    visit weights_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Weight was successfully destroyed"
  end
end
