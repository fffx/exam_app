require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :student_tom
    @user.token || @user.regenerate_token
  end

  def test_login
    post login_path
    json_body => {error: String}
    # assert_equal response.code, '401'
    assert_response :unauthorized

    post login_path, params: {email: @user.email, password: 'password'}
    response.parsed_body.symbolize_keys => { token: }
  end


  def test_logout
    delete logout_path
    assert_response :unauthorized

    old_token = @user.token

    delete logout_path, headers: { 'Authorization' => @user.token }
    json_body => { success: }

    @user.reload
    assert old_token != @user.token

    delete logout_path, headers: { 'Authorization' => old_token }
    assert_response :unauthorized
  end
end
