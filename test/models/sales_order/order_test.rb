require 'test_helper'

class SalesOrder::OrderTest < ActiveSupport::TestCase
  fixtures %w(
    head/voucher_rows
    sales_order/orders
    sales_order/rows
  )

  setup do
    @order = sales_order_orders :so_one
  end

  test 'fixture should be valid' do
    assert @order.valid?
    assert_equal "Acme Corporation", @order.company.nimi
  end

  test 'model relations' do
    assert @order.accounting_rows.count > 0
    assert @order.rows.count > 0
    assert_equal "L", @order.rows.first.tyyppi
  end
end
