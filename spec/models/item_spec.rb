require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品新規登録' do
    context '出品登録できるとき' do
      it 'image,name,text,category_id,sale_status_id,shipping_fee_id,prefecture_id,days_toship_id,price,user_idが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '出品登録できないとき' do
      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'textが空では登録できない' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Text can't be blank")
      end
      it 'category_idが---では登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 0')
      end
      it 'sale_status_idが---では登録できない' do
        @item.sale_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Sale status must be other than 0')
      end
      it 'shipping_fee_idが---では登録できない' do
        @item.shipping_fee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping fee must be other than 0')
      end
      it 'prefecture_idが---では登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 0')
      end
      it 'days_to_ship_idが---では登録できない' do
        @item.days_to_ship_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Days to ship must be other than 0')
      end

      it 'pliceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'pliceが300円未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid')
      end

      it 'pliceが10000000円以上では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid')
      end

      it 'pliceが半角英数混合では登録できないこと' do
        @item.price = '300a'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid')
      end

      it 'pliceが半角英語だけでは登録できないこと' do
        @item.price = 'apple'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid')
      end

      it 'pliceが全角数字の場合は登録できないこと' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid')
      end

      it 'imageが空の場合は保存ができないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end
