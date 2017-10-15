# == Schema Information
#
# Table name: el_sockets
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  code          :string
#  url           :string
#  address       :string
#  gps_lat       :float
#  gps_lng       :float
#  voltage       :integer
#  i_limit       :integer
#  price_per_kWh :float
#  in_use        :boolean
#  current_user  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  frequency     :integer
#  mqtt_id       :string

require 'test_helper'

class ElSocketsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    user_one = users(:one)
    sign_in user_one
    @el_socket = el_sockets(:one)
  end

  test "should get index" do
    get el_sockets_url
    assert_response :success
  end

  test "should get new" do
    get new_el_socket_url
    assert_response :success
  end

  test "should create el_socket" do
    assert_difference('ElSocket.count') do
      post el_sockets_url, params: { el_socket: { address: @el_socket.address, code: @el_socket.code, 
        current_user: @el_socket.current_user, gps_lat: @el_socket.gps_lat, gps_lng: @el_socket.gps_lng, 
        i_limit: @el_socket.i_limit, in_use: @el_socket.in_use, price_per_kWh: @el_socket.price_per_kWh, 
        url: @el_socket.url, user_id: 1, voltage: @el_socket.voltage } }
    end
    
    #TODO: figure out this => assert_redirected_to el_socket_url(ElSocket.last)
  end

  test "should show el_socket ss" do
    get el_socket_url(@el_socket)
    assert_response :success
  end

  test "should get edit" do
    get edit_el_socket_url(@el_socket)
    assert_response :success
  end

  # test "should update el_socket" do
    # patch el_socket_url(@el_socket), params: { el_socket: { address: @el_socket.address, code: @el_socket.code, current_user: @el_socket.current_user, gps_lat: @el_socket.gps_lat, gps_lng: @el_socket.gps_lng, i_limit: @el_socket.i_limit, in_use: @el_socket.in_use, price_per_kWh: @el_socket.price_per_kWh, url: @el_socket.url, user_id: @el_socket.user_id, voltage: @el_socket.voltage } }
    # assert_redirected_to el_socket_url(@el_socket)
  # end

  # test "should destroy el_socket" do
    # assert_difference('ElSocket.count', -1) do
      # delete el_socket_url(@el_socket)
#       
    # end
# 
    # assert_redirected_to el_sockets_url
#  end
  
end
