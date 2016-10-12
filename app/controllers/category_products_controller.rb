class CategoryProductsController < ApplicationController
  before_action :find_category

  def show
    @product = @category.products.active.find(params[:id])
  end

  def add
    @product = @category.products.active.find(params[:id])
    @cart = find_cart
    @cart.add_item(@product)
    session[:cart_id] = @cart.id
    redirect_to :back, notice: 'Cart had been updated!'
  end

  private

  # Check it in`rake routes`
  # category_product GET /categories/:category_id/products/:id(.:format) category_products#show
  def find_category
    @category = Category.enabled.find(params[:category_id])
  end

  def find_cart
    if session[:cart_id]
      Cart.find_by(id: session[:cart_id]) || Cart.new
    else
      Cart.new
    end
  end
end
