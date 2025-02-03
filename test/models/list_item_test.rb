require "test_helper"

class ListItemTest < ActiveSupport::TestCase
  fixtures :list_items, :shopping_lists, :materials
  
  setup do
    @list_item = list_items(:one)
  end

  test "should be valid with valid attributes" do
    assert @list_item.valid?
  end

  test "should belong to shopping list" do
    assert_respond_to @list_item, :shopping_list
    assert @list_item.shopping_list.present?
  end

  test "should belong to material" do
    assert_respond_to @list_item, :material
    assert @list_item.material.present?
  end

  test "should require shopping list" do
    @list_item.shopping_list = nil
    assert_not @list_item.valid?
  end

  test "should require material" do
    @list_item.material = nil
    assert_not @list_item.valid?
  end

  test "should require quantity" do
    @list_item.quantity = nil
    assert_not @list_item.valid?
  end

  test "quantity should be positive" do
    @list_item.quantity = 0
    assert_not @list_item.valid?
    @list_item.quantity = -1
    assert_not @list_item.valid?
  end

  test "quantity should be an integer" do
    @list_item.quantity = 1.5
    assert_not @list_item.valid?, "Non-integer quantities should be invalid"
  end
end
