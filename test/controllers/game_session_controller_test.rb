require "test_helper"

class GameSessionControllerTest < ActionDispatch::IntegrationTest
  test "should succeed init" do
    post '/api/bubbles/1', as: :json
    assert_response :success
  end
end
