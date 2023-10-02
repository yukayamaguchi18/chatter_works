require "test_helper"

class Public::WorksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_works_new_url
    assert_response :success
  end

  test "should get show" do
    get public_works_show_url
    assert_response :success
  end
end
