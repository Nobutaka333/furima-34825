class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :user_birthday
    with_options format: {
      with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）を使用してください'
    } do
      validates :last_name
      validates :first_name
    end
    with_options format: {
      with: /\A[ァ-ヶ一]+\z/, message: 'は全角カナを使用してください'
    } do
      validates :last_name_kana
      validates :first_name_kana
    end
    validates :password, format: {
      with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は6文字以上かつ英数字をそれぞれ含めてください'
    }
  end
  has_many :items
end
