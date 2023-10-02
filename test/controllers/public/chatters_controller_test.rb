require "test_helper"

class Public::ChattersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_chatters_show_url
    assert_response :success
  end
end
