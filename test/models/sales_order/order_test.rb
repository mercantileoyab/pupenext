require 'test_helper'

class Head::SalesOrder::OrderTest < ActiveSupport::TestCase
  fixtures %w(
    head/sales_order/orders
    head/sales_order/rows
    head/voucher_rows
  )

  setup do
    @order = head_sales_order_orders :so_one
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
