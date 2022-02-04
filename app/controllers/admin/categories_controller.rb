class Admin::CategoriesController < ApplicationController
  
  # index all existing categories
  def index
    @categories = Category.order(id: :desc).all
  end

  # create a blank category
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end


  private

  # security function for parameter passed into Category.new
  def category_params
    params.require(:category).permit(
      :name
    )
  end

end
