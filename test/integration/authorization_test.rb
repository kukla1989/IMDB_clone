require "test_helper"

class AuthorizationTest < ActionDispatch::IntegrationTest
   include Devise::Test::IntegrationHelpers
    include Warden::Test::Helpers
  test "should display login page" do
    get new_user_session_path
    assert_response :success
  end

  test "should display sign up page" do
    get new_user_registration_path
    assert_response :success
  end

  test "log in with valid email password" do
    @roma = users(:roma)
    post user_session_path, params: {user: {email: @roma.email,
                                            password: 'password'}}
    assert_response :redirect
    assert_equal "Signed in successfully.", flash[:notice]
  end


  test "user can create account" do
    assert_difference 'User.count', 1 do
      post user_registration_path, params: {user: {email: "user@mail.com",
                                                 password: "password"}}
    end
  end


   test "user cant create account with existed email" do
     assert_no_difference 'User.count' do
       post user_registration_path, params: {user: {email: "roma@mail.com",
                                                    password: "password"}}
     end
   end

end
