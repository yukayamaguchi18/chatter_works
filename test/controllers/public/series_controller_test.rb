require "test_helper"

class Public::SeriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_series_index_url
    assert_response :success
  end

  test "should get create" do
    get public_series_create_url
    assert_response :success
  end

  test "should get update" do
    get public_series_update_url
    assert_response :success
  end

  test "should get destroy" do
    get public_series_destroy_url
    assert_response :success
  end
end
