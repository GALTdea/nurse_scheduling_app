require "test_helper"

class WeeksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @week = weeks(:one)
  end

  test "should get index" do
    get weeks_url
    assert_response :success
  end

  test "should get new" do
    get new_week_url
    assert_response :success
  end

  test "should create week" do
    assert_difference("Week.count") do
      post weeks_url, params: { week: { end_date: @week.end_date, start_date: @week.start_date, week_number: @week.week_number, year_id: @week.year_id } }
    end

    assert_redirected_to week_url(Week.last)
  end

  test "should show week" do
    get week_url(@week)
    assert_response :success
  end

  test "should get edit" do
    get edit_week_url(@week)
    assert_response :success
  end

  test "should update week" do
    patch week_url(@week), params: { week: { end_date: @week.end_date, start_date: @week.start_date, week_number: @week.week_number, year_id: @week.year_id } }
    assert_redirected_to week_url(@week)
  end

  test "should destroy week" do
    assert_difference("Week.count", -1) do
      delete week_url(@week)
    end

    assert_redirected_to weeks_url
  end
end
