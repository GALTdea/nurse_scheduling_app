require "test_helper"

class PeriodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @period = periods(:one)
  end

  test "should get index" do
    get periods_url
    assert_response :success
  end

  test "should get new" do
    get new_period_url
    assert_response :success
  end

  test "should create period" do
    assert_difference("Period.count") do
      post periods_url, params: { period: { begining_date: @period.begining_date, end_date: @period.end_date, name: @period.name, number: @period.number } }
    end

    assert_redirected_to period_url(Period.last)
  end

  test "should show period" do
    get period_url(@period)
    assert_response :success
  end

  test "should get edit" do
    get edit_period_url(@period)
    assert_response :success
  end

  test "should update period" do
    patch period_url(@period), params: { period: { begining_date: @period.begining_date, end_date: @period.end_date, name: @period.name, number: @period.number } }
    assert_redirected_to period_url(@period)
  end

  test "should destroy period" do
    assert_difference("Period.count", -1) do
      delete period_url(@period)
    end

    assert_redirected_to periods_url
  end
end
