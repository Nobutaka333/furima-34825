class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sale_status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :days_to_ship
  has_one_attached :image


  with_options presence: true do 
    with_options numericality: { other_than: 1 }  do 
    validates :category_id
    validates :sale_status_id
    validates :shipping_fee_id
    validates :prefectures_id
    validates :days_to_ship_id
    end
    validates :price,  numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is invalid"}
  end
  belongs_to :user
end
