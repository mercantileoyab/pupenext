require 'test_helper'

class FiscalYearTest < ActiveSupport::TestCase
  fixtures %w(fiscal_years)

  setup do
    @one = fiscal_years(:one)
    @two = fiscal_years(:two)
    @user = users(:bob)
    @company = companies(:acme)
  end

  test 'fixtures are valid' do
    assert @one.valid?
    assert @two.valid?
  end

  test 'relations' do
    assert_not_nil @one.company
  end

  test 'should have begin and end date' do
    fiscal_year = FiscalYear.new
    fiscal_year.tilikausi_alku = Date.today
    fiscal_year.laatija = @user
    fiscal_year.muuttaja = @user
    fiscal_year.company = @company
    refute fiscal_year.valid?

    fiscal_year.tilikausi_loppu = Date.today + 1
    assert fiscal_year.valid?
  end

  test 'start should be before end' do
    fiscal_year = FiscalYear.new
    fiscal_year.tilikausi_alku = Date.today
    fiscal_year.laatija = @user
    fiscal_year.muuttaja = @user
    fiscal_year.company = @company
    refute fiscal_year.valid?

    fiscal_year.tilikausi_loppu = Date.today - 1
    refute fiscal_year.valid?

    fiscal_year.tilikausi_loppu = Date.today + 1
    assert fiscal_year.valid?
  end

  test "should be able to set date as a hash" do
    @one.tilikausi_alku = { day: 31, month: 2, year: 2014}
    refute @one.valid?

    @one.tilikausi_alku = { day: 1, month: 1, year: 2014}
    assert @one.valid?

    @one.tilikausi_loppu = { day: 32, month: 12, year: 2014}
    refute @one.valid?

    @one.tilikausi_loppu = { day: 31, month: 12, year: 2014}
    assert @one.valid?
  end
end
