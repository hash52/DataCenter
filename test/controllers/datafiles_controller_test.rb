require 'test_helper'

class DatafilesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get datafiles_new_url
    assert_response :success
  end

end
