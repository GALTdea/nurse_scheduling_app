require "application_system_test_case"

class NursesTest < ApplicationSystemTestCase
  setup do
    @nurse = nurses(:one)
  end

  test "visiting the index" do
    visit nurses_url
    assert_selector "h1", text: "Nurses"
  end

  test "should create nurse" do
    visit nurses_url
    click_on "New nurse"

    fill_in "Name", with: @nurse.name
    fill_in "Time", with: @nurse.time
    click_on "Create Nurse"

    assert_text "Nurse was successfully created"
    click_on "Back"
  end

  test "should update Nurse" do
    visit nurse_url(@nurse)
    click_on "Edit this nurse", match: :first

    fill_in "Name", with: @nurse.name
    fill_in "Time", with: @nurse.time
    click_on "Update Nurse"

    assert_text "Nurse was successfully updated"
    click_on "Back"
  end

  test "should destroy Nurse" do
    visit nurse_url(@nurse)
    click_on "Destroy this nurse", match: :first

    assert_text "Nurse was successfully destroyed"
  end
end
