class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum amount_billed: { credit_card: 0, transfer: 1 }
  enum order_status: { payment_waiting: 0, payment_confimation: 1, in_production: 2, preparing_deliverry: 3, delivered: 4 }

end
