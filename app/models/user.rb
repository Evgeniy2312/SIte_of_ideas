class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :omniauthable,
         :timeoutable,
         jwt_revocation_strategy: self

  enum role: {
    investor: 1,
    entrepreneur: 2,
    admin: 3
  }


  validates :name,
            presence: true,
            length: { maximum: 50 }
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: Devise.email_regexp}
  validates :password,
            length: { maximum: 12 }

  has_one_attached :avatar
  has_and_belongs_to_many :ideas, foreign_key: 'user_id'
  has_many :likes, through: :ideas, dependent: :destroy
  has_many :dislikes, through: :ideas, dependent: :destroy
  has_and_belongs_to_many :rates, through: :ideas, dependent: :destroy, foreign_key: 'user_id'
  has_many :comments, dependent: :destroy

end
