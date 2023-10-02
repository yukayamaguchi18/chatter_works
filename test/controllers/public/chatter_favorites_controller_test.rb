require "test_helper"

class Public::ChatterFavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_chatter_favorites_index_url
    assert_response :success
  end
end
