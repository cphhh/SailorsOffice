require 'test_helper'

class SlackControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get slack_create_url
    assert_response :success
  end

end
