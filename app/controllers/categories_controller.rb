class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = @category.products.available.includes(:category).order(:name)
  end
end
