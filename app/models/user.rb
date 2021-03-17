class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :nickname, presence: true
         validates :last_name, presence: true, format: { 
           with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）を使用してください' }
         validates :first_name, presence: true, format: { 
          with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）を使用してください' }
         validates :last_name_kana, presence: true, format: { 
          with: /\A[ァ-ヶ一]+\z/, message: 'は全角カナを使用してください' }
         validates :first_name_kana, presence: true, format: { 
          with: /\A[ァ-ヶ一]+\z/, message: 'は全角カナを使用してください' }
         validates :user_birthday, presence: true
         validates :password, format: {
            with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "は6文字以上かつ英数字をそれぞれ含めてください"  }
end
