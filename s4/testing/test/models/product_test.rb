require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  def setup
    @product = products(:valid_drink)
  end
  
  test 'with valid price and name validation succeeds' do
    assert @product.valid?
  end

  test 'with valid price but same name validation fails' do
    new_product = Product.new(@product.attributes)
    assert !new_product.valid?
  end

  test 'with invalid price validation fails' do
    @product.price = -10
    assert !@product.valid?
  end

  test 'with valid floar price validation succeeds' do
    @product.price = 10.15
    assert @product.valid?
  end

end
