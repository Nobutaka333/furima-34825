class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building_name, :tel, :order_id, :token

  with_options presence: true do
    validates :postal_code
    validates :city
    validates :address
    validates :tel
    validates :user_id
    validates :item_id
    with_options numericality: { other_than: 0 } do
      validates :prefecture_id
    end
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, tel: tel, order_id: order.id)
  end
end