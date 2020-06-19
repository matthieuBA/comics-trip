require 'test_helper'

class PrivateMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get private_messages_index_url
    assert_response :success
  end

  test "should get show" do
    get private_messages_show_url
    assert_response :success
  end

  test "should get create" do
    get private_messages_create_url
    assert_response :success
  end

  test "should get delete" do
    get private_messages_delete_url
    assert_response :success
  end

end
