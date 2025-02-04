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

  test "should have many list items" do
    assert_respond_to @material, :list_items
  end

  test "should have many shopping lists through list items" do
    assert_respond_to @material, :shopping_lists
  end

  # Price relationship tests
  test "should have price relationships" do
    assert_respond_to @material, :price
  end

  # Validation tests
  test "should be valid with valid attributes" do
    assert @material.valid?
  end

  test "name should be present" do
    @material.name = nil
    assert_not @material.valid?
  end

  test "material_category should be present" do
    @material.material_category = nil
    assert_not @material.valid?
    assert_includes @material.errors[:material_category], "must exist"
  end

  test "should destroy associated list items when destroyed" do
    initial_count = @material.list_items.count
    new_list_item = @material.list_items.create!(quantity: 1, shopping_list: shopping_lists(:one))
    assert_difference('ListItem.count', -(initial_count + 1)) do
      @material.destroy
    end
  end
end
