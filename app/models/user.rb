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
         jwt_revocation_strategy: self



  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i



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
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password,
            length: { maximum: 12 }

  has_and_belongs_to_many :ideas, foreign_key: 'user_id'
  has_many :likes, through: :ideas, dependent: :destroy
  has_many :dislikes, through: :ideas, dependent: :destroy
  has_and_belongs_to_many :rates, through: :ideas, dependent: :destroy, foreign_key: 'user_id'
  has_many :comments, through: :ideas, dependent: :destroy

end
