require "test_helper"

class CurrencyPriceTest < ActiveSupport::TestCase
  setup do
    @currency_price = currency_prices(:one)
  end

  # Association tests
  test "should belong to material" do
    assert_respond_to @currency_price, :material
    assert @currency_price.material.present?
  end

  # Validation tests
  test "should be valid with valid attributes" do
    assert @currency_price.valid?
  end

  test "material should be present" do
    @currency_price.material = nil
    assert_not @currency_price.valid?
  end

  test "should be valid with zero values" do
    @currency_price.copper = 0
    @currency_price.silver = 0
    @currency_price.gold = 0
    assert @currency_price.valid?
  end

  test "currency values should be non-negative" do
    @currency_price.copper = -1
    assert_not @currency_price.valid?
    
    @currency_price.copper = 0
    @currency_price.silver = -1
    assert_not @currency_price.valid?
    
    @currency_price.silver = 0
    @currency_price.gold = -1
    assert_not @currency_price.valid?
  end

  test "should be valid with nil values" do
    @currency_price.copper = nil
    @currency_price.silver = nil
    @currency_price.gold = nil
    assert @currency_price.valid?
  end
end
