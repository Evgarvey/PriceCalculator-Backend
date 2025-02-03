require "test_helper"

class LiquidPriceTest < ActiveSupport::TestCase
  setup do
    @liquid_price = liquid_prices(:one)
  end

  # Association tests
  test "should belong to material" do
    assert_respond_to @liquid_price, :material
    assert @liquid_price.material.present?
  end

  # Validation tests
  test "should be valid with valid attributes" do
    assert @liquid_price.valid?
  end

  test "material should be present" do
    @liquid_price.material = nil
    assert_not @liquid_price.valid?
  end

  test "should be valid with zero price per unit" do
    @liquid_price.price_per_unit = 0
    assert @liquid_price.valid?
  end

  test "should be valid with nil price per unit" do
    @liquid_price.price_per_unit = nil
    assert @liquid_price.valid?
  end

  test "price per unit should be non-negative when present" do
    @liquid_price.price_per_unit = -1
    assert_not @liquid_price.valid?
  end

  test "should be valid with zero unit size" do
    @liquid_price.unit_size = 0
    assert @liquid_price.valid?
  end

  test "should be valid with nil unit size" do
    @liquid_price.unit_size = nil
    assert @liquid_price.valid?
  end

  test "unit size should be non-negative when present" do
    @liquid_price.unit_size = -1
    assert_not @liquid_price.valid?
  end
end
