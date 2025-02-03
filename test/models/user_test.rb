require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  # Association tests
  test "should have many shopping lists" do
    assert_respond_to @user, :shopping_lists
  end

  test "should have many list items through shopping lists" do
    assert_respond_to @user, :list_items
  end

  # Validation tests
  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be in valid format" do
    invalid_emails = ['user@', '@example.com', 'user@.com', 'user.com']
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email} should not be valid"
    end
  end

  test "password should be present for new users" do
    user = User.new(email: "test@example.com")
    assert_not user.valid?
  end

  test "password should have minimum length" do
    @user.password = "a" * 5
    assert_not @user.valid?
  end

  # Dependent destroy test
  test "should destroy associated shopping lists when destroyed" do
    initial_count = @user.shopping_lists.count
    @user.shopping_lists.create!(name: "Test List")
    assert_difference('ShoppingList.count', -(initial_count + 1)) do
      @user.destroy
    end
  end

  test "should authenticate with correct password" do
    user = User.create(email: "test@example.com", password: "password123")
    assert user.valid_password?("password123")
  end

  test "should not authenticate with incorrect password" do
    user = User.create(email: "test@example.com", password: "password123")
    assert_not user.valid_password?("wrongpassword")
  end
end
