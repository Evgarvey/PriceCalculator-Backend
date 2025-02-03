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

  test "should be valid with zero price per gram" do
    @precious_price.price_per_gram = 0
    assert @precious_price.valid?
  end

  test "should be valid with nil price per gram" do
    @precious_price.price_per_gram = nil
    assert @precious_price.valid?
  end

  test "price per gram should be non-negative when present" do
    @precious_price.price_per_gram = -1
    assert_not @precious_price.valid?
  end

  test "should be valid with zero density" do
    @precious_price.density = 0
    assert @precious_price.valid?
  end

  test "should be valid with nil density" do
    @precious_price.density = nil
    assert @precious_price.valid?
  end

  test "density should be non-negative when present" do
    @precious_price.density = -1
    assert_not @precious_price.valid?
  end
end
