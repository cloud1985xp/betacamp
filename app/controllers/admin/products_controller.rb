class Admin::ProductsController < Admin::BaseController
  def index
    @products = Product.page(params[:page])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: 'Created Successfully.'
    else
      render :edit
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      redirect_to admin_products_path, notice: 'Updated Successfully.'
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path, notice: 'Product was deleted successfully'
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :description, :content,
      :active, :price, :category_id
    )
  end
end
