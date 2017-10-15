require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest

  test "should get home page" do
    get root_url
    assert_response :success
  end

  test "should get about page" do
    get page_path('about')
    assert_response :success
  end

  test "should get contact page" do
    get page_path('contact')
    assert_response :success
  end


end