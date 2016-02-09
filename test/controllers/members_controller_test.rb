require "test_helper"

class MembersControllerTest < ActionController::TestCase
  test "the truth" do
    assert true
  end

  test "index" do
  	login_as("taro")
  	get :index
  	assert_response :success
  end

  test "index before_login" do 
  	get :index
    assert_response :forbidden
  end 
  
end
