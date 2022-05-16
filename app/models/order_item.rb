class OrderItem < ApplicationRecord

  has_many :orders, dependent: :destroy
  has_many :items, dependent: :destroy

  enum production_status: { production_not_possible: 0, production_waiting: 1, in_production: 2, production_complete: 3 }

  def subtotal
    price_at_purchase*amount
  end

end
