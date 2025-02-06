require "test_helper"

class Api::V1::SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)  # Assuming you have a user fixture
  end

  test "should login user with valid credentials" do
    puts "\nDEBUG: Attempting login with valid credentials"
    post api_v1_login_path, params: {
      user: {
        email: @user.email,
        password: 'password123'  # Match this with your fixture's password
      }
    }, as: :json

    puts "Response status: #{response.status}"
    puts "Response body: #{response.body}"
    
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 200, json_response['status']['code']
    assert_equal 'Logged in successfully.', json_response['status']['message']
    assert json_response.dig('data', 'user', 'id').present?
    assert json_response.dig('data', 'user', 'email').present?
  rescue => e
    puts "Error in login test: #{e.message}"
    puts "Response body: #{response.body}"
    puts e.backtrace
    raise e
  end

  test "should not login user with invalid credentials" do
    puts "\nDEBUG: Attempting login with invalid credentials"
    post api_v1_login_path, params: {
      user: {
        email: @user.email,
        password: 'wrongpassword'
      }
    }, as: :json

    puts "Response status: #{response.status}"
    puts "Response body: #{response.body}"
    
    assert_response :unauthorized
  rescue => e
    puts "Error in invalid login test: #{e.message}"
    puts "Response body: #{response.body}"
    puts e.backtrace
    raise e
  end

  test "should logout user" do
    puts "\nDEBUG: Attempting logout"
    sign_in @user
    delete api_v1_logout_path, as: :json

    puts "Response status: #{response.status}"
    puts "Response body: #{response.body}"
    
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 200, json_response['status']['code']
    assert_equal 'Logged out successfully.', json_response['status']['message']
  rescue => e
    puts "Error in logout test: #{e.message}"
    puts "Response body: #{response.body}"
    puts e.backtrace
    raise e
  end
end 