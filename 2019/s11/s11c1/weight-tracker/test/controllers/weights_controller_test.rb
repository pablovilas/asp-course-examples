require 'test_helper'

class WeightsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weight = weights(:one)
  end

  test "should get index" do
    get weights_url
    assert_response :success
  end

  test "should get new" do
    get new_weight_url
    assert_response :success
  end

  test "should create weight" do
    assert_difference('Weight.count') do
      post weights_url, params: { weight: { sample_date: @weight.sample_date, value: @weight.value } }
    end

    assert_redirected_to weight_url(Weight.last)
  end

  test "should show weight" do
    get weight_url(@weight)
    assert_response :success
  end

  test "should get edit" do
    get edit_weight_url(@weight)
    assert_response :success
  end

  test "should update weight" do
    patch weight_url(@weight), params: { weight: { sample_date: @weight.sample_date, value: @weight.value } }
    assert_redirected_to weight_url(@weight)
  end

  test "should destroy weight" do
    assert_difference('Weight.count', -1) do
      delete weight_url(@weight)
    end

    assert_redirected_to weights_url
  end
end
