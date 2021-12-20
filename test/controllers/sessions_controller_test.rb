require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test 'should login' do
    post '/api/auth/register', params: {
      email: 'user@example.com',
      username: 'user',
      password: 'user1user'
    }, as: :json
    assert_response :success
    post '/api/auth/login', params: {
      login: 'user@example.com',
      password: 'user1user'
    }
    assert_response :success
  end
end
