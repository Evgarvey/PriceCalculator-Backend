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

  test "should be valid with zero usd ratio" do
    @currency_price.usd_ratio = 0
    assert @currency_price.valid?
  end

  test "should be valid with nil usd ratio" do
    @currency_price.usd_ratio = nil
    assert @currency_price.valid?
  end

  test "usd ratio should be non-negative when present" do
    @currency_price.usd_ratio = -1
    assert_not @currency_price.valid?
  end
end
