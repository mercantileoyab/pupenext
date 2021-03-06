require 'test_helper'

class Keyword::ProductKeywordTypeTest < ActiveSupport::TestCase
  fixtures %w(
    keyword/product_keyword_types
  )

  setup do
    @keyword = keyword_product_keyword_types :webshopdesc
  end

  test 'fixtures are valid' do
    assert @keyword.valid?
  end

  test 'product keyword' do
    assert_equal "webshopdesc", @keyword.product_key
  end
end
