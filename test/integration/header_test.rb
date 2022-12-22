require "test_helper"

class HeaderTest < ActionDispatch::IntegrationTest

  test "links in header should be visible without log in" do
    get root_path
    assert_select "a.navbar-brand[href=?]", root_path
    assert_select "a.nav-link[href=?]", new_user_session_path
    assert_select "a.nav-link[href=?]", edit_user_registration_path, count: 0
    assert_select "a.nav-link[href=?]", destroy_user_session_path, count: 0
    assert_select "a.nav-link[href=?]", new_movie_path, count: 0
  end

  test  "some links in header should not be visible without log in" do
    sign_in users(:roma)
    get root_path
    assert_select "a.nav-link[href=?]", edit_user_registration_path
    assert_select "a.nav-link[href=?]", destroy_user_session_path
    assert_select "a.nav-link[href=?]", new_user_session_path, count: 0
  end

  test "header should appear in show movie" do
    get movie_path(Movie.first)
    assert_select "nav.navbar"
    assert_select "a.navbar-brand[href=?]", root_path
  end
end
