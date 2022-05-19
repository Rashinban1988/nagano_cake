class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  enum is_deleted: { true: true, false: false }

  validates :first_name,       presence: true
  validates :last_name,        presence: true
  validates :first_name_kana,  presence: true
  validates :last_name_kana,   presence: true
  validates :postal_code,      presence: true
  validates :address,          presence: true
  validates :telephone_number, presence: true, uniqueness: true
  validates :email,            presence: true, uniqueness: true

  def my_address
    "　〒 " + postal_code.insert(3, '-') + address + last_name + first_name
  end

end
