class OrderItem < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum production_status: { production_not_possible: 0, production_waiting: 1, in_production: 2, production_complete: 3 }

  def subtotal
    price_at_purchase*amount
  end

end
