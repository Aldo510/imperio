require "test_helper"

class MatchesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get matches_edit_url
    assert_response :success
  end
end
