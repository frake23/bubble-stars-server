require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should register user' do
    post '/api/auth/register', params: {
      email: 'user@example.com',
      username: 'user',
      password: 'user1user'
    }, as: :json
    assert_response :success
  end
end
