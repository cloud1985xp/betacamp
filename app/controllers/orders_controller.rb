class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart, only: [:new, :create]

  def index
    @orders = current_user.orders.page(params[:page])
  end

  def new
    @order = current_user.orders.new(email: current_user.email)
  end

  def create
    @order = current_user.orders.new(order_params)
    @order.add_items(current_cart)
    if @order.save
      current_cart.destroy
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(
      :name, :email, :mobile, :address
    )
  end

  def current_cart
    @current_cart ||= find_cart
  end

  def find_cart
    if session[:cart_id]
      Cart.find_by(id: session[:cart_id]) || Cart.new
    else
      Cart.new
    end
  end

  def check_cart
    redirect_to :back, notice: "購物車沒有東西喔" if current_cart.empty?
  end

  helper_method :current_cart
end