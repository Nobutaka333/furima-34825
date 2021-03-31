FactoryBot.define do
  factory :order_address do
    token{'123456789'}
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    address { '青山1-1' }
    building_name { '東京ハイツ' }
    tel { '09012345678' }
  end
end
