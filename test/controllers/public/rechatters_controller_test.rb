require "test_helper"

class Public::RechattersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_rechatters_index_url
    assert_response :success
  end
end
