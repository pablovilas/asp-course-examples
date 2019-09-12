require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  
  test 'get all products is successful' do
    get '/products'
    assert_response :success
  end

  test 'get product with id #465 returns not found' do
    get '/products/465'
    assert_response :not_found
  end

  test 'get product with id #1 returns success' do
    get '/products/1'
    assert_response :success
  end

  test 'saves valid product' do
    assert_difference 'Product.count', 1 do
      post '/products', params: { product: { price: 10, name: 'Product name' } }
    end
    assert_response :created
  end

  test 'does not saves invalid product' do
    post '/products', params: { product: { price: -10, name: 'Product name' } }
    assert_response :error
  end

  test 'delete product with id #1 returns success' do
    delete '/products/1'
    assert_response :success
  end

end
