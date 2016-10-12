class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
  end
end
