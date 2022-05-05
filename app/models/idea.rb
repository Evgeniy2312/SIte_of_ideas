class Idea < ApplicationRecord

  enum access: {
    personal: 1,
    common: 2
  }

  has_many :comments, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :rate, dependent: :destroy
  has_and_belongs_to_many :users, foreign_key: 'idea_id'
  has_and_belongs_to_many :tags, foreign_key: 'idea_id'

end
