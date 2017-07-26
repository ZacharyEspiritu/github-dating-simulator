require 'test_helper'

class UserDataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_data = user_data(:one)
  end

  test "should get index" do
    get user_data_url
    assert_response :success
  end

  test "should get new" do
    get new_user_data_url
    assert_response :success
  end

  test "should create user_data" do
    assert_difference('UserData.count') do
      post user_data_url, params: { user_data: { data: @user_data.data, username: @user_data.username } }
    end

    assert_redirected_to user_data_url(UserData.last)
  end

  test "should show user_data" do
    get user_data_url(@user_data)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_data_url(@user_data)
    assert_response :success
  end

  test "should update user_data" do
    patch user_data_url(@user_data), params: { user_data: { data: @user_data.data, username: @user_data.username } }
    assert_redirected_to user_data_url(@user_data)
  end

  test "should destroy user_data" do
    assert_difference('UserData.count', -1) do
      delete user_data_url(@user_data)
    end

    assert_redirected_to user_data_url
  end
end
