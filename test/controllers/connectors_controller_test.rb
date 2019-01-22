require 'test_helper'


class ConnectorsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    user_one = users(:one)
    sign_in user_one

    I18n.locale = :en
    @connector = connectors(:three)
  end
  

  test "should get index" do
    get connectors_url
    assert_response :success
  end

  test "should get new" do
    get new_connector_url
    assert_response :success
  end

  test "should create connector" do
    assert_difference('Connector.count') do
      post connectors_url, params: { connector: { aws_conn_id: @connector.aws_conn_id, box_id: @connector.box_id, code: @connector.code, current_user: @connector.current_user, frequency: @connector.frequency, i_max: @connector.i_max, power: @connector.power, price_per_kWh: @connector.price_per_kWh, status: @connector.status, url: @connector.url, voltage: @connector.voltage } }
    end

    assert_redirected_to connector_url(Connector.last, locale: I18n.locale)
  end

  test "should show connector" do
    get connector_url(@connector)
    assert_response :success
  end

  test "should get edit" do
    get edit_connector_url(@connector)
    assert_response :success
  end

  test "should update connector" do
    patch connector_url(@connector), params: { connector: { aws_conn_id: @connector.aws_conn_id, box_id: @connector.box_id, code: @connector.code, current_user: @connector.current_user, frequency: @connector.frequency, i_max: @connector.i_max, power: @connector.power, price_per_kWh: @connector.price_per_kWh, status: @connector.status, url: @connector.url, voltage: @connector.voltage } }
    assert_redirected_to connector_url(@connector, locale: I18n.locale)
  end

  test "should destroy connector" do
    assert_difference('Connector.count', -1) do
      delete connector_url(@connector)
    end

    assert_redirected_to connectors_url(locale: I18n.locale)
  end
end
