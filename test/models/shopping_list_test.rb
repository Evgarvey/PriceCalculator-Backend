require "test_helper"

class ShoppingListTest < ActiveSupport::TestCase
  setup do
    @shopping_list = shopping_lists(:one)
  end

  # Association tests
  test "should belong to user" do
    assert_respond_to @shopping_list, :user
    assert @shopping_list.user.present?
  end

  test "should have many list items" do
    assert_respond_to @shopping_list, :list_items
  end

  test "should have many materials through list items" do
    assert_respond_to @shopping_list, :materials
  end

  # Validation tests
  test "should be valid with valid attributes" do
    assert @shopping_list.valid?
  end

  test "name should be present" do
    @shopping_list.name = nil
    assert_not @shopping_list.valid?
  end

  test "user should be present" do
    @shopping_list.user = nil
    assert_not @shopping_list.valid?
  end

  # Dependent destroy test
  test "should destroy associated list items when destroyed" do
    @shopping_list.list_items.create!(material: materials(:one), quantity: 1)
    assert_difference('ListItem.count', -1) do
      @shopping_list.destroy
    end
  end
end
