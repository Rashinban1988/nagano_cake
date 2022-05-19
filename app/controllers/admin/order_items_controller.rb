class Admin::OrderItemsController < ApplicationController

  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    @order_item.update(order_item_params)
      if params[:order_item][:production_status] == "in_production"
        @order_item.order.update(order_status: "in_production")
        @order_item.update(production_status: "in_production")
      elsif params[:order_item][:production_status] == "production_complete"
        status = 0
        @order.order_items.each do |order_item|
          if order_item.production_status != "production_complete"
            status = 1
          end
        end
        if status == 0
          @order_item.order.update(order_status: "preparing_delivery")
          @order_item.update(production_status: "production_complete")
        end
      else
      end
    redirect_to admin_order_path(@order_item.order)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:production_status)
  end


end
