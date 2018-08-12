require 'test_helper'

class RegattasControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get regattas_new_url
    assert_response :success
  end

end
