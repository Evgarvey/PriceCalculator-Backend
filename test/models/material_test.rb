require "test_helper"

class MaterialTest < ActiveSupport::TestCase
  fixtures :materials, :material_categories
  
  setup do
    @material = materials(:one)
  end

  # Association tests
  test "should belong to material_category" do
    assert_respond_to @material, :material_category
  end

  test "should have one price" do
    assert_respond_to @material, :price
  end

  test "should have many list_items" do
    assert_respond_to @material, :list_items
  end

  test "should have many shopping lists through list items" do
    assert_respond_to @material, :shopping_lists
  end

  # Validation tests
  test "should be valid with valid attributes" do
    assert @material.valid?
  end

  test "name should be present" do
    @material.name = nil
    assert_not @material.valid?
    assert_includes @material.errors[:name], "can't be blank"
  end

  test "material_category should be present" do
    @material.material_category = nil
    assert_not @material.valid?
    assert_includes @material.errors[:material_category], "must exist"
  end

  test "should destroy associated price when destroyed" do
    assert_difference('Price.count', -1) do
      @material.destroy
    end
  end

  test "should destroy associated list_items when destroyed" do
    list_item_count = @material.list_items.count  # Count list items for this material
    
    assert_difference('ListItem.count', -list_item_count) do
      @material.destroy
    end
  end
end
