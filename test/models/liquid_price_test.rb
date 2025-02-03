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

  test "should be valid with zero price per liter" do
    @liquid_price.price_per_liter = 0
    assert @liquid_price.valid?
  end

  test "should be valid with nil price per liter" do
    @liquid_price.price_per_liter = nil
    assert @liquid_price.valid?
  end

  test "price per liter should be non-negative when present" do
    @liquid_price.price_per_liter = -1
    assert_not @liquid_price.valid?
  end

  test "should be valid with zero density" do
    @liquid_price.density = 0
    assert @liquid_price.valid?
  end

  test "should be valid with nil density" do
    @liquid_price.density = nil
    assert @liquid_price.valid?
  end

  test "density should be non-negative when present" do
    @liquid_price.density = -1
    assert_not @liquid_price.valid?
  end
end
