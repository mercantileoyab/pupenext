require 'test_helper'

class DataImportControllerTest < ActionController::TestCase
  setup do
    login users(:bob)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should update products" do
    file = fixture_file_upload 'files/product_upload_test.xlsx'
    post :products, file: file
    assert_redirected_to data_import_path
  end
end
