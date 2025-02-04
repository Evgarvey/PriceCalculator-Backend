require "test_helper"

class PriceTest < ActiveSupport::TestCase
  test "price_per_unit should be present" do
    price = Price.new
    assert_not price.valid?
    assert_includes price.errors[:price_per_unit], "can't be blank"
  end

  test "price_per_unit should be non-negative" do
    price = Price.new(price_per_unit: -1)
    assert_not price.valid?
    assert_includes price.errors[:price_per_unit], "must be greater than or equal to 0"
  end
end 