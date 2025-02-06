require "test_helper"

class Api::V1::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "route exists" do
    puts "\nDEBUG: Available routes:"
    puts Rails.application.routes.routes.map { |r| [r.verb, r.path.spec.to_s] }
    
    assert_routing(
      { path: '/api/v1/signup', method: :post },
      { controller: 'api/v1/registrations', action: 'create' }
    )
  end

  test "should create new user with valid data" do
    assert_difference -> { User.count } do
      post api_v1_signup_path, params: {
        user: {
          email: 'newuser@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
      }, as: :json
    end

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 200, json_response['status']['code']
    assert_equal 'Signed up successfully.', json_response['status']['message']
  end

  test "should not create user with invalid data" do
    assert_no_difference -> { User.count } do
      post api_v1_signup_path, params: {
        user: {
          email: 'invalid-email',
          password: 'short',
          password_confirmation: 'nomatch'
        }
      }, as: :json
    end

    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)
    assert_equal 422, json_response['status']['code']
    assert_equal 'User could not be created.', json_response['status']['message']
  end
end 