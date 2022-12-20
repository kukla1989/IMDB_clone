require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get movies_index_url
    assert_response :success
  end

  test "movies index should have title 'Movies'" do
    get root_path
    assert_select "h1", "Movies"
  end

end
