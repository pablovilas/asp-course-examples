require 'test_helper'

class SubscribersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subscriber = subscribers(:one)
  end

  test "should get index" do
    get subscribers_url
    assert_response :success
  end

  test "should get new" do
    get new_subscriber_url
    assert_response :success
  end

  test "should create subscriber" do
    assert_difference('Subscriber.count') do
      post subscribers_url, params: { subscriber: { email: @subscriber.email, name: @subscriber.name } }
    end

    assert_redirected_to subscriber_url(Subscriber.last)
  end

  test "should show subscriber" do
    get subscriber_url(@subscriber)
    assert_response :success
  end

  test "should get edit" do
    get edit_subscriber_url(@subscriber)
    assert_response :success
  end

  test "should update subscriber" do
    patch subscriber_url(@subscriber), params: { subscriber: { email: @subscriber.email, name: @subscriber.name } }
    assert_redirected_to subscriber_url(@subscriber)
  end

  test "should destroy subscriber" do
    assert_difference('Subscriber.count', -1) do
      delete subscriber_url(@subscriber)
    end

    assert_redirected_to subscribers_url
  end
end
