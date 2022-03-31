class CartItem < ApplicationRecord

  has_many :orders
  belongs_to :item
  belongs_to :customer

end
