class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sale_status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :days_to_ship
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :text
    with_options numericality: { other_than: 0 } do
      validates :category_id
      validates :sale_status_id
      validates :shipping_fee_id
      validates :prefecture_id
      validates :days_to_ship_id
    end
    validates :price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'is invalid' }
    validates :image, unless: :was_attached?
  end

  def was_attached?
    image.attached?
  end
  belongs_to :user
end
