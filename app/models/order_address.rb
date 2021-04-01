class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building_name, :tel, :token

  with_options presence: true do
    validates :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 0 }
    validates :city
    validates :address
    validates :tel, numericality: { only_integer: true }, length: { maximum: 11 }
    validates :user_id
    validates :item_id
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address,
                   building_name: building_name, tel: tel, order_id: order.id)
  end
end
