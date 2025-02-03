require "test_helper"

class MaterialTest < ActiveSupport::TestCase
  setup do
    @material = materials(:one)
  end

  # Association tests
  test "should belong to material category" do
    assert_respond_to @material, :material_category
    assert @material.material_category.present?
  end

  test "should have many list items" do
    assert_respond_to @material, :list_items
  end

  test "should have many shopping lists through list items" do
    assert_respond_to @material, :shopping_lists
  end

  # Price relationship tests
  test "should have price relationships" do
    assert_respond_to @material, :currency_price
    assert_respond_to @material, :common_material_price
    assert_respond_to @material, :liquid_price
    assert_respond_to @material, :precious_material_price
  end

  # Validation tests
  test "should be valid with valid attributes" do
    assert @material.valid?
  end

  test "name should be present" do
    @material.name = nil
    assert_not @material.valid?
  end

  test "material category should be present" do
    @material.material_category = nil
    assert_not @material.valid?
  end

  test "should destroy associated list items when destroyed" do
    @material.list_items.create!(quantity: 1, shopping_list: shopping_lists(:one))
    assert_difference('ListItem.count', -1) do
      @material.destroy
    end
  end
end
