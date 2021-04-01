require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, item_id: item.id, user_id: user.id)
      sleep 0.1
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      it '建物名がなくても保存できること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空だと保存できないこと' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空だと保存できないこと' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank",
                                                               'Postal code is invalid. Include hyphen(-)')
      end

      it '郵便番号はハイフンがないと保存できないこと' do
        @order_address.postal_code = '12345678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '郵便番号が全角数字だと保存できないこと' do
        @order_address.postal_code = '０００-００００'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '郵便番号が英数字だと保存できないこと' do
        @order_address.postal_code = 'a12-4567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '都道府県が--では保存できないこと' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture must be other than 0')
      end
      it '市区町村が空だと保存できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @order_address.tel = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tel can't be blank", 'Tel is not a number')
      end
      it '電話番号にハイフンが入っていると保存できないこと' do
        @order_address.tel = '000-3333'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel is not a number')
      end

      it '電話番号が半角英字だと保存できないこと' do
        @order_address.tel = '000a00000'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel is not a number')
      end

      it 'telが全角数字だと保存できないこと' do
        @order_address.tel = '００００００００'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel is not a number')
      end

      it 'telが全角かなだと保存できないこと' do
        @order_address.tel = 'あいうえお'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel is not a number')
      end

      it 'telが半角カナだと保存できないこと' do
        @order_address.tel = 'ｱｱｱｱｱｱｱｱ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel is not a number')
      end

      it 'telが12文字以上だと保存できないこと' do
        @order_address.tel = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel is too long (maximum is 11 characters)')
      end

      it 'user_idが空だと保存できないこと' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと保存できないこと' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
