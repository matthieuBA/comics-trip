require 'test_helper'

class GoogleBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get google_books_index_url
    assert_response :success
  end

  test "should get show" do
    get google_books_show_url
    assert_response :success
  end

end
