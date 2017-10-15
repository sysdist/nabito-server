require 'test_helper'

class SocketLoadsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    user_one = users(:one)
    sign_in user_one
    @socket_load = socket_loads(:one)
  end

  test "should get index" do
    get socket_loads_url
    assert_response :success
  end

  # test "should get new" do
    # get new_socket_load_url
    # assert_response :success
  # end
# 
  # test "should create socket_load" do
    # assert_difference('SocketLoad.count') do
      # post socket_loads_url, params: { socket_load: { el_socket_id: @socket_load.el_socket_id, i_current: @socket_load.i_current, power: @socket_load.power, time: @socket_load.time, voltage: @socket_load.voltage } }
    # end
# 
    # assert_redirected_to socket_load_url(SocketLoad.last)
  # end
# 
  # test "should show socket_load" do
    # get socket_load_url(@socket_load)
    # assert_response :success
  # end
# 
  # test "should get edit" do
    # get edit_socket_load_url(@socket_load)
    # assert_response :success
  # end
# 
  # test "should update socket_load" do
    # patch socket_load_url(@socket_load), params: { socket_load: { el_socket_id: @socket_load.el_socket_id, i_current: @socket_load.i_current, power: @socket_load.power, time: @socket_load.time, voltage: @socket_load.voltage } }
    # assert_redirected_to socket_load_url(@socket_load)
  # end
# 
  # test "should destroy socket_load" do
    # assert_difference('SocketLoad.count', -1) do
      # delete socket_load_url(@socket_load)
    # end
# 
    # assert_redirected_to socket_loads_url
  # end
end
