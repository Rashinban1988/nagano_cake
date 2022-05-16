class Public::OrdersController < ApplicationController

  def new
    @orders = Order.all
    @order = Order.new
    @address = current_customer.address
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @total = @order_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      @order.customer.cart_items.each do |i|
        @order_items = OrderItem.new(order_item_params)
        @order_items.order_id = @order.id
        @order_items.production_status = 0
        @order_items.item_id = i.item_id
        @order_items.amount = (i.amount).to_i
        @order_items.price_at_purchase = (i.item.price * 1.1).to_i
        @order_items.save
      end
      current_customer.cart_items.destroy_all
      redirect_to complete_order_path
    else
      @order = Order.new
      render :new
    end
  end

  def order_confirmation
    @order = Order.new(order_params)
    @customer = Customer.find(current_customer.id)

    if params[:select_address] == "0"
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.first_name + current_customer.last_name

    elsif params[:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.shipping_postal_code = @address.postal_code
      @order.shipping_address = @address.address
      @order.shipping_name = @address.name

    elsif params[:select_address] == "2"

    end

     @cart_items = CartItem.all
     @total = 0
     @order.postage = 800
     @order.claimed = @order.postage + @total
  end

  def complete
  end


  # 商品合計（税込）の計算
  def calculate(user)
    total_price = 0
    user.cart_items.each do |cart_item|
      total_price += cart_item.amount * cart_item.item.price
    end
    return (total_price * 1.1).floor
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :shipping_postal_code, :shipping_address, :shipping_name, :postage, :claimed, :amount_billed, :order_status, :cart_items_id)
  end

  def address_params
     params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end

  def order_item_params
    params.permit(:item_id, :order_id, :price_at_perchase, :amount, :production_status)
  end


end
