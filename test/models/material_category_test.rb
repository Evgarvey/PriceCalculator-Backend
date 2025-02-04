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
    category = material_categories(:one)
    assert_respond_to category, :materials
  end

  test "name should be present" do
    category = MaterialCategory.new
    assert_not category.valid?
    assert_includes category.errors[:name], "can't be blank"
  end

  test "name should be unique" do
    duplicate_category = @material_category.dup
    assert_not duplicate_category.valid?
  end

  test "should destroy associated materials when destroyed" do
    category = material_categories(:one)
    material_count = category.materials.count  # Count materials in this category
    
    assert_difference('Material.count', -material_count) do
      category.destroy
    end
  end
end