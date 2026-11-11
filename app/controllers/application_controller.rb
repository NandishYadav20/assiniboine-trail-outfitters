class ApplicationController < ActionController::Base
  helper_method :cart, :current_admin_user

  private

  def cart
    session[:cart] ||= {}
  end

  def cart_lines
    cart.filter_map do |product_id, qty|
      product = Product.available.find_by(id: product_id)
      { product: product, quantity: qty.to_i } if product
    end
  end

  def current_admin_user
    @current_admin_user ||= AdminUser.find_by(id: session[:admin_user_id])
  end

  def require_admin
    redirect_to new_admin_session_path, alert: "Please log in." unless current_admin_user
  end
end
