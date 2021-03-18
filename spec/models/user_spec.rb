require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nickname,email,password,password_confirmation,user_birthday,last_name,first_name,last_name_kana,first_name_kanaが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上かつ英数字混合であれば登録できること' do
        @user.password = '00000a'
        @user.password_confirmation = '00000a'
        expect(@user).to be_valid
      end
      it 'emailは@が含まれていれば登録できること' do
        @user.email = 'aaaa@a.com'
        expect(@user).to be_valid
      end
      it 'last_nameは全角（漢字・ひらがな・カタカナ）で登録できること' do
        @user.last_name = '田中たなかタナカ'
        expect(@user).to be_valid
      end
      it 'first_nameは全角（漢字・ひらがな・カタカナ）で登録できること' do
        @user.first_name = '太郎たろうタロウ'
        expect(@user).to be_valid
      end
      it 'last_name_kanaは全角カタカナで登録できること' do
        @user.last_name_kana = 'タナカ'
        expect(@user).to be_valid
      end
      it 'first_name_kanaは全角カタカナで登録できること' do
        @user.first_name = 'カタカナ'
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'user_birthdayが空では登録できない' do
        @user.user_birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("User birthday can't be blank")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは＠が含まれていないと登録できないこと' do
        @user.email = 'aaaaa.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordとpassword_confirmationが異なっていれば、登録できないこと' do
        @user.password = 'a00000'
        @user.password_confirmation = 'b00000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードは6文字未満では登録できないこと' do
        @user.password = 'a0000'
        @user.password_confirmation = 'a0000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードは英字のみでは登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は6文字以上かつ英数字をそれぞれ含めてください')
      end
      it 'パスワードは数字のみでは登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は6文字以上かつ英数字をそれぞれ含めてください')
      end
      it 'last_nameは半角カタカナでは登録できないこと' do
        @user.last_name = 'ﾀﾅｶ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name は全角（漢字・ひらがな・カタカナ）を使用してください')
      end
      it 'last_nameは半角英数字では登録できないこと' do
        @user.last_name = 'tanaka0'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name は全角（漢字・ひらがな・カタカナ）を使用してください')
      end
      it 'last_nameが全角英数字では登録できない' do
        @user.last_name = 'ＴＡＮＡＫＡ０'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name は全角（漢字・ひらがな・カタカナ）を使用してください')
      end
      it 'first_nameは半角カタカナでは登録できないこと' do
        @user.first_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角（漢字・ひらがな・カタカナ）を使用してください')
      end
      it 'first_nameは半角英数字では登録できないこと' do
        @user.first_name = 'taro0'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角（漢字・ひらがな・カタカナ）を使用してください')
      end
      it 'first_nameが全角英数字では登録できないこと' do
        @user.first_name = 'ＴＡＲＯ０'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角（漢字・ひらがな・カタカナ）を使用してください')
      end
      it 'last_name_kanaは半角カタカナでは登録できないこと' do
        @user.last_name_kana = 'ﾀﾅｶ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カナを使用してください')
      end
      it 'last_name_kanaは半角英数字では登録できないこと' do
        @user.last_name_kana = 'tanaka0'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カナを使用してください')
      end
      it 'last_name_kanaが全角英数字では登録できないこと' do
        @user.last_name_kana = 'ＴＡＮＡＫＡ０'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カナを使用してください')
      end
      it 'last_name_kanaは全角ひらがなでは登録できないこと' do
        @user.last_name_kana = 'たなか'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カナを使用してください')
      end
      it 'last_name_kanaは全角漢字では登録できないこと' do
        @user.last_name_kana = '田中'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カナを使用してください')
      end
      it 'first_name_kanaは半角カタカナでは登録できないこと' do
        @user.first_name_kana = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カナを使用してください')
      end
      it 'first_name_kanaは半角英数字では登録できないこと' do
        @user.first_name_kana = 'taro0'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カナを使用してください')
      end
      it 'first_name_kanaが全角英数字では登録できないこと' do
        @user.first_name_kana = 'ＴＡＲＯ０'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カナを使用してください')
      end
      it 'first_name_kanaは全角ひらがなでは登録できないこと' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カナを使用してください')
      end
      it 'first_name_kanaは全角漢字では登録できないこと' do
        @user.first_name_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カナを使用してください')
      end
    end
  end
end
