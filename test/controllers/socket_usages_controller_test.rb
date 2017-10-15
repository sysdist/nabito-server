require 'test_helper'

class SocketUsagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    user_one = users(:one)
    sign_in user_one
    @socket_usage = socket_usages(:one)
  end

  test "should get index" do
    get socket_usages_url
    assert_response :success
  end

  # test "should get new" do
    # get new_socket_usage_url
    # assert_response :success
  # end
# 
  # test "should create socket_usage" do
    # assert_difference('SocketUsage.count') do
      # post socket_usages_url, params: { socket_usage: { amount: @socket_usage.amount, date: @socket_usage.date, el_socket_id: @socket_usage.el_socket_id, end_time: @socket_usage.end_time, kWhs: @socket_usage.kWhs, start_time: @socket_usage.start_time, user_id: @socket_usage.user_id } }
    # end
# 
    # assert_redirected_to socket_usage_url(SocketUsage.last)
  # end
# 
  # test "should show socket_usage" do
    # get socket_usage_url(@socket_usage)
    # assert_response :success
  # end
# 
  # test "should get edit" do
    # get edit_socket_usage_url(@socket_usage)
    # assert_response :success
  # end
# 
  # test "should update socket_usage" do
    # patch socket_usage_url(@socket_usage), params: { socket_usage: { amount: @socket_usage.amount, date: @socket_usage.date, el_socket_id: @socket_usage.el_socket_id, end_time: @socket_usage.end_time, kWhs: @socket_usage.kWhs, start_time: @socket_usage.start_time, user_id: @socket_usage.user_id } }
    # assert_redirected_to socket_usage_url(@socket_usage)
  # end
# 
  # test "should destroy socket_usage" do
    # assert_difference('SocketUsage.count', -1) do
      # delete socket_usage_url(@socket_usage)
    # end
# 
    # assert_redirected_to socket_usages_url
#  end
end
