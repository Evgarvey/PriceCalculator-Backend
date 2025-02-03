require "test_helper"

class CommonMaterialPriceTest < ActiveSupport::TestCase
  setup do
    @common_price = common_material_prices(:one)
  end

  # Association tests
  test "should belong to material" do
    assert_respond_to @common_price, :material
    assert @common_price.material.present?
  end

  # Validation tests
  test "should be valid with valid attributes" do
    assert @common_price.valid?
  end

  test "material should be present" do
    @common_price.material = nil
    assert_not @common_price.valid?
  end

  test "should be valid with zero price" do
    @common_price.price = 0
    assert @common_price.valid?
  end

  test "should be valid with nil price" do
    @common_price.price = nil
    assert @common_price.valid?
  end

  test "price should be non-negative when present" do
    @common_price.price = -1
    assert_not @common_price.valid?
  end
end
