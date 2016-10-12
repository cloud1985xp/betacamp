class CategoriesController < ApplicationController
  def show
    @category = Category.enabled.find(params[:id])
    @products = @category.products.active.page(params[:page])
    @comments = @category.comments.includes(:user)
  end
end
