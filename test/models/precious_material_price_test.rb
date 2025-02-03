require "test_helper"

class PreciousMaterialPriceTest < ActiveSupport::TestCase
  setup do
    @precious_price = precious_material_prices(:one)
  end

  # Association tests
  test "should belong to material" do
    assert_respond_to @precious_price, :material
    assert @precious_price.material.present?
  end

  # Validation tests
  test "should be valid with valid attributes" do
    assert @precious_price.valid?
  end

  test "material should be present" do
    @precious_price.material = nil
    assert_not @precious_price.valid?
  end

  test "should be valid with zero price per unit" do
    @precious_price.price_per_unit = 0
    assert @precious_price.valid?
  end

  test "should be valid with nil price per unit" do
    @precious_price.price_per_unit = nil
    assert @precious_price.valid?
  end

  test "price per unit should be non-negative when present" do
    @precious_price.price_per_unit = -1
    assert_not @precious_price.valid?
  end

  test "should be valid with zero unit weight" do
    @precious_price.unit_weight = 0
    assert @precious_price.valid?
  end

  test "should be valid with nil unit weight" do
    @precious_price.unit_weight = nil
    assert @precious_price.valid?
  end

  test "unit weight should be non-negative when present" do
    @precious_price.unit_weight = -1
    assert_not @precious_price.valid?
  end
end
