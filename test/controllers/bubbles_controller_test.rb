require "test_helper"

class BubblesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bubble = bubbles(:one)
  end

  test "should get index" do
    get bubbles_url, as: :json
    assert_response :success
  end

  test "should create bubble" do
    assert_difference('Bubble.count') do
      post bubbles_url, params: { bubble: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show bubble" do
    get bubble_url(@bubble), as: :json
    assert_response :success
  end

  test "should update bubble" do
    patch bubble_url(@bubble), params: { bubble: {  } }, as: :json
    assert_response 200
  end

  test "should destroy bubble" do
    assert_difference('Bubble.count', -1) do
      delete bubble_url(@bubble), as: :json
    end

    assert_response 204
  end
end
