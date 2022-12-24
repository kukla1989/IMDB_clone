require "test_helper"

class RateTest < ActiveSupport::TestCase
  def setup
    @movie = movies(:agent)
    @user = users(:roma)
  end

  test "active_rates.create should create new record rate" do
    assert_difference "Rate.count", 1 do
      @movie.active_rates.create(user: @user, rating: 5)
    end
  end
end
