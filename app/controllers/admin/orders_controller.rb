class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      redirect_to admin_order_path(@order), notice: 'Updated Successfully.'
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :mobile, :paid)
  end
end
