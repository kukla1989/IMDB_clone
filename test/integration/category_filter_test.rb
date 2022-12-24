require "test_helper"

class CategoryFilterTest < ActionDispatch::IntegrationTest
  test "everyone should see category form" do
    get root_path
    assert_select "input[value=?]", "show"
    assert_select "label", "Choose subject"
  end

  test "catogory form should work" do
    get root_path, params: {category: "Comedy"}
    Movie.where(category: Category.find_by_title("Comedy"))
         .first(30).each do |movie|
      assert_select "a[href=?]", movie_path(movie)
    end
  end
end
