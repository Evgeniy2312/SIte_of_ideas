class User < ApplicationRecord
  attribute :password
  attribute :password_confirmation
  attribute :old_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password

  enum role: {
    investor: 1,
    entrepreneur: 2,
    admin: 3
  }

  before_save { email.downcase! }
  validates :name,
            presence: true,
            length: { maximum: 50 }
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :password,
            confirmation: true,
            allow_blank: true,
            length: { maximum: 12 }
  validate :correct_old_password,
           on: :update, if: -> { password.present? }
  has_and_belongs_to_many :ideas
  has_one :like, through: :idea, dependent: :destroy
  has_one :dislike, through: :idea, dependent: :destroy
  has_one :rate, through: :idea, dependent: :destroy
  has_many :comments, through: :idea, dependent: :destroy

  # validate:password_complexity
  # validates :telephone, presence: true, length: {maximum: 20}
  # validates :skype, presence: true
  # validates :country, presence: true
  private


  def correct_old_password
    return if BCrypt::Password.new(password_digest_was) == old_password

    errors.add :old_password, 'is incorrect'
  end

  # Закомментировал, как будет все корректно работать, то раскомментирую
  # def password_complexity
  #   return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/
  #
  #   msg = 'complexity requirement not met. Length should be 8-70 characters and ' \
  #         'include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  #   errors.add :password, msg
  # end

  # def password_presence
  #   errors.add(:password, :blank) if password_digest.blank?
  # end
end
