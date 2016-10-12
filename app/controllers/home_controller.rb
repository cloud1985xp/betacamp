class HomeController < ApplicationController
  def index
    @categories = Category.where(enabled: true).all
    @products = Product.order('id desc').page(params[:page])
  end
end
