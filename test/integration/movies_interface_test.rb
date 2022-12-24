require "test_helper"

class MoviesInterface < ActionDispatch::IntegrationTest
end

class MoviesInterfaceTest < MoviesInterface
  def setup
    @user = users(:roma)
    sign_in @user
    @movie = movies(:agent)
  end
  
  test "should paginate movies if count more then 30" do
    get root_path
    assert_select "div.pagination"
  end

  test "user should not be able delete movie" do
    assert_no_difference "Movie.count" do
      delete movie_path(movies(:agent))
    end
  end

  test "user cant see edit, delete movie" do
    get movie_path(movies(:agent))
    assert_match  "edit", response.body
    assert_match  "delete", response.body
  end
end


class MovieInterfaceAdminTest < MoviesInterface
  def setup
    sign_in users(:admin)
  end

  test "should create movie" do
    description = "some new description for movie"
    title = "unique title"
    average_rating = 7
    assert_difference "Movie.count", 1 do
      post movies_path, params: {movie: {description: description, title: title, average_rating: average_rating,
                                         category_id: categories(:comedy).id}}
    end
    movie = Movie.find_by_title(title)
    assert_equal movie.average_rating, average_rating
    assert_redirected_to movie_path(movie)
    follow_redirect!
    assert_match description, response.body
  end

  test "admin can see edit, delete movie" do
    get movie_path(movies(:agent))
    assert_select "a", "edit"
    assert_select "a", "delete"
  end

  test "admin should be able delete movie" do
    assert_difference "Movie.count", -1 do
      delete movie_path(movies(:agent))
    end
  end

  test "should create error but not create movie with invalid submission" do
    assert_no_difference "Movie.count" do
      post movies_path, params: {movie: {description: "", title: "some title"}}
    end
    assert_select "div.alert"
  end

  test "if admin remain field with rate blank during creating movie rate should be 10" do
    description = "some new description for movie"
    title = "unique title 2"
    assert_difference "Movie.count", 1 do
      post movies_path, params: {movie: {description: description, title: title,
                                         category_id: categories(:comedy).id}}
    end
    movie = Movie.find_by_title(title)
    assert_redirected_to movie_path(movie)
    assert_equal movie.average_rating, 10
    follow_redirect!
  end

end


