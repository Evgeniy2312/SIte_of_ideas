class Idea < ApplicationRecord

  #belongs_to :owner, class_name: "User"
  # belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :rate, dependent: :destroy
  has_and_belongs_to_many :users

end
