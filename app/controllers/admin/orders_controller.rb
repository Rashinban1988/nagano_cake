class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @cart_items = @order.customer.cart_items
    @total_price = calculate(@order)
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
      if params[:order][:order_status] == "payment_confirmation"
        @order.order_items.each do |order_item|
          order_item.production_status = 1
          order_item.update(production_status: order_item.production_status)
        end
      end
    redirect_to admin_order_path(@order)
  end

  private

  def calculate(user)
   total_price = 0
   user.order_items.each do |order_item|
     total_price += order_item.amount * order_item.price_at_purchase
   end
   return total_price
  end

  def order_params
    params.require(:order).permit(:customer_id, :shipping_postal_code, :shipping_address, :shipping_name, :shipping_cost, :postage, :amount_billed, :order_status)
  end

end
