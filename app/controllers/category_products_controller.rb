class CategoryProductsController < ApplicationController
  before_action :find_category

  def show
    @product = @category.products.active.find(params[:id])
  end

  private

  # Check it in`rake routes`
  # category_product GET /categories/:category_id/products/:id(.:format) category_products#show
  def find_category
    @category = Category.enabled.find(params[:category_id])
  end
end
