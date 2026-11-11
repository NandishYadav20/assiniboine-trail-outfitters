class PagesController < ApplicationController
  def home
    @categories = Category.order(:name)
    @new_products = Product.available.includes(:category).order(created_at: :desc).limit(8)
  end

  def about; end
end
