require "test_helper"

class ListItemTest < ActiveSupport::TestCase
  setup do
    @list_item = list_items(:one)
  end

  # Association tests
  test "should belong to shopping list" do
    assert_respond_to @list_item, :shopping_list
    assert @list_item.shopping_list.present?
  end

  test "should belong to material" do
    assert_respond_to @list_item, :material
    assert @list_item.material.present?
  end

  # Validation tests
  test "should be valid with valid attributes" do
    assert @list_item.valid?
  end

  test "shopping list should be present" do
    @list_item.shopping_list = nil
    assert_not @list_item.valid?
  end

  test "material should be present" do
    @list_item.material = nil
    assert_not @list_item.valid?
  end

  test "quantity should be present" do
    @list_item.quantity = nil
    assert_not @list_item.valid?
  end

  test "quantity should be greater than 0" do
    @list_item.quantity = 0
    assert_not @list_item.valid?
    @list_item.quantity = -1
    assert_not @list_item.valid?
  end

  test "quantity should be an integer" do
    @list_item.quantity = 1.5
    assert_not @list_item.valid?
  end
end
