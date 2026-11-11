class CartController < ApplicationController
  def show
    @lines = cart_lines
    @subtotal = @lines.sum { |l| l[:product].price * l[:quantity] }
  end

  def add
    product = Product.available.find(params[:product_id])
    if product.stock_quantity < 1
      return redirect_to product_path(product), alert: "Sorry, #{product.name} is out of stock."
    end

    qty = params[:quantity].to_i.clamp(1, product.stock_quantity)
    key = product.id.to_s
    cart[key] = [cart[key].to_i + qty, product.stock_quantity].min
    redirect_to cart_path, notice: "#{product.name} added to your cart."
  end
end
