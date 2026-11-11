class ProductsController < ApplicationController
  def show
    @product = Product.available.find(params[:id])
  end

  def search
    @categories = Category.order(:name)
    @q = params[:q].to_s.strip
    @category_id = params[:category_id].presence
    @products = Product.available.in_category(@category_id).keyword(@q).includes(:category).order(:name)
  end
end
