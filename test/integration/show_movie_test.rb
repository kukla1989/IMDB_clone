require "test_helper"

class ShowMovieTest < ActionDispatch::IntegrationTest
  def setup
    @movie = movies(:agent)
  end

  test "should display content, title and subject" do
    get movie_path(@movie)
    assert_select "h3", @movie.title
    assert_select "p", @movie.description
    assert_match  @movie.category.title, response.body
  end

  test "link to edit end delete" do
    sign_in(users(:admin))
    get movie_path @movie
    assert_select "a", "edit"
    assert_select "a", "delete"
  end
end


