class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :customers, through: :cart_items
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  belongs_to :genre

  has_one_attached :item_image

end
