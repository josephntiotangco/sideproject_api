require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { contact_number: @user.contact_number, create_date: @user.create_date, created_by: @user.created_by, email: @user.email, encrypted_password: @user.encrypted_password, password: @user.password, remember_created_at: @user.remember_created_at, reset_password_sent_at: @user.reset_password_sent_at, reset_password_token: @user.reset_password_token, role_id: @user.role_id, update_date: @user.update_date, updated_by: @user.updated_by, user_code: @user.user_code, user_id: @user.user_id, username: @user.username } }, as: :json
    end

    assert_response 201
  end

  test "should show user" do
    get user_url(@user), as: :json
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { contact_number: @user.contact_number, create_date: @user.create_date, created_by: @user.created_by, email: @user.email, encrypted_password: @user.encrypted_password, password: @user.password, remember_created_at: @user.remember_created_at, reset_password_sent_at: @user.reset_password_sent_at, reset_password_token: @user.reset_password_token, role_id: @user.role_id, update_date: @user.update_date, updated_by: @user.updated_by, user_code: @user.user_code, user_id: @user.user_id, username: @user.username } }, as: :json
    assert_response 200
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user), as: :json
    end

    assert_response 204
  end
end
