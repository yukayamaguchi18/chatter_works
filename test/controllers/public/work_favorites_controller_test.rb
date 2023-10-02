require "test_helper"

class Public::WorkFavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_work_favorites_index_url
    assert_response :success
  end
end
