class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.page(params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: 'Created Successfully.'
    else
      render :edit
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to admin_categories_path, notice: 'Updated Successfully.'
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path, notice: 'Category was deleted successfully'
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :enabled)
  end
end
