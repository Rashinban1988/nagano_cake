class Item < ApplicationRecord

  has_many :customers, through: :cart_items
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  belongs_to :genre

  enum is_active: { true: true, false: false }
  has_one_attached :item_image

end
