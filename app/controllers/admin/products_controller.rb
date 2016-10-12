class Admin::ProductsController < Admin::BaseController
  before_action :find_product, only: %i(show edit update destroy)

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
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to admin_products_path, notice: 'Updated Successfully.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: 'Product was deleted successfully'
  end

  private

  def find_product
    @product = Product.find(params[:id].to_i)
  end

  def product_params
    params.require(:product).permit(
      :name, :description, :content,
      :active, :price, :category_id
    )
  end
end
