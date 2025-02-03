require "test_helper"

class MaterialCategoryTest < ActiveSupport::TestCase
  fixtures :material_categories, :materials
  
  setup do
    @material_category = material_categories(:one)
  end

  test "should be valid with valid attributes" do
    assert @material_category.valid?
  end

  test "should have many materials" do
    assert_respond_to @material_category, :materials
  end

  test "name should be present" do
    @material_category.name = nil
    assert_not @material_category.valid?
  end

  test "name should be unique" do
    duplicate_category = @material_category.dup
    assert_not duplicate_category.valid?
  end

  test "should destroy associated materials when destroyed" do
    initial_count = @material_category.materials.count
    @material_category.materials.create!(name: "Test Material")
    assert_difference('Material.count', -(initial_count + 1)) do
      @material_category.destroy
    end
  end
end