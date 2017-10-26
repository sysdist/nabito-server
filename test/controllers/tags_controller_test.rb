require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    user_one = users(:one)
    sign_in user_one
    @tag = tags(:one)
    I18n.locale = :en
  end

  test "should get index" do
    get tags_url
    assert_response :success
  end

  test "should get new" do
    assert_difference('Tag.count') do
      get new_tag_url
    end
    #assert_redirected_to tags_url
    #assert_response :success
  end

  # test "should create tag" do
    # assert_difference('Tag.count') do
      # post tags_url, params: { tag: { pin: @tag.pin, status: @tag.status, token: @tag.token, tag_type: @tag.tag_type, user_id: @tag.user_id, user_ref: @tag.user_ref } }
    # end
# 
    # #assert_redirected_to tag_url(Tag.last)
  # end

  test "should show tag" do
    get tag_url(@tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_tag_url(@tag)
    assert_response :success
  end

  test "should update tag" do
    patch tag_url(@tag), params: { tag: { pin: @tag.pin, status: @tag.status, token: @tag.token, type: @tag.tag_type, user_id: @tag.user_id, user_ref: @tag.user_ref } }
    #assert_redirected_to tag_url(@tag)
  end

  test "should destroy tag" do
    assert_difference('Tag.count', -1) do
      delete tag_url(@tag)
    end

    #assert_redirected_to tags_url
  end
end
