require "test_helper"

class RateT < ActionDispatch::IntegrationTest
end

class RateTes < RateT
  test "without log in user cant see form for rate movie" do
    get root_path
    assert_select "input[value=?]", "rate", false
  end
end


class RateUserTest < RateT
  def setup
    @user = users(:roma)
    sign_in @user
  end

  test "user can see form for rate movie" do
    get root_path
    assert_select "input[value=?]", "rate"
  end
end