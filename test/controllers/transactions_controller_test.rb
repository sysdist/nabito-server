require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction = transactions(:one)
  end

  test "should get index" do
    get transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_transaction_url
    assert_response :success
  end

  test "should create transaction" do

    assert_difference('Transaction.count') do
      post transactions_url, params: { transaction: { amount: @transaction.amount, begin_time: @transaction.begin_time, box_id: @transaction.box_id, connector_id: @transaction.connector_id, creditor_id: @transaction.creditor_id, date_posted: @transaction.date_posted, debtor_id: @transaction.debtor_id, end_time: @transaction.end_time, kWhs_used: @transaction.kWhs_used, price_per_kWh: @transaction.price_per_kWh, status: @transaction.status } }
    end

    assert_redirected_to transaction_url(Transaction.last, locale: I18n.locale)
  end

  test "should show transaction" do
    get transaction_url(@transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_transaction_url(@transaction)
    assert_response :success
  end

  test "should update transaction" do
    patch transaction_url(@transaction), params: { transaction: { amount: @transaction.amount, begin_time: @transaction.begin_time, box_id: @transaction.box_id, connector_id: @transaction.connector_id, creditor_id: @transaction.creditor_id, date_posted: @transaction.date_posted, debtor_id: @transaction.debtor_id, end_time: @transaction.end_time, kWhs_used: @transaction.kWhs_used, price_per_kWh: @transaction.price_per_kWh, status: @transaction.status } }
    assert_redirected_to transaction_url(@transaction, locale: I18n.locale)
  end

  test "should destroy transaction" do
    assert_difference('Transaction.count', -1) do
      delete transaction_url(@transaction)
    end

    assert_redirected_to transactions_url(locale: I18n.locale )
  end
end
