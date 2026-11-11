class CheckoutController < ApplicationController
  def new
    return redirect_to(cart_path, alert: "Your cart is empty.") if cart_lines.empty?

    @customer = Customer.new
  end

  def create
    @lines = cart_lines
    return redirect_to(cart_path, alert: "Your cart is empty.") if @lines.empty?

    @customer = Customer.new(customer_params)
    return render(:new, status: :unprocessable_entity) unless @customer.valid?

    short = @lines.find { |l| l[:quantity] > l[:product].stock_quantity }
    return redirect_to(cart_path, alert: "Not enough stock for #{short[:product].name}.") if short

    order = nil
    Order.transaction do
      @customer.save!
      subtotal = @lines.sum { |l| l[:product].price * l[:quantity] }
      province = @customer.province
      breakdown = province.tax_breakdown(subtotal)
      tax_total = breakdown.values.sum

      order = Order.create!(
        customer: @customer,
        province: province,
        order_number: generate_order_number,
        status: "new",
        subtotal: subtotal,
        gst_amount: breakdown.fetch("GST", 0),
        pst_amount: breakdown.fetch("PST", 0),
        hst_amount: breakdown.fetch("HST", 0),
        total: subtotal + tax_total
      )

      @lines.each do |l|
        order.order_items.create!(product: l[:product], quantity: l[:quantity], unit_price: l[:product].price)
        l[:product].decrement!(:stock_quantity, l[:quantity])
      end
    end

    session[:cart] = {}
    redirect_to order_confirmation_path(order.order_number), notice: "Thank you! Your order has been placed."
  end

  def confirmation
    @order = Order.includes(order_items: :product).find_by!(order_number: params[:order_number])
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :phone, :address_line,
                                     :city, :province_id, :postal_code)
  end

  def generate_order_number
    "ATO-#{Time.current.strftime('%Y%m%d')}-#{SecureRandom.hex(3).upcase}"
  end
end
