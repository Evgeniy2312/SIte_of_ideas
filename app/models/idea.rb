class Idea < ApplicationRecord

  validates :name,
            presence: true,
            length: { maximum: 50 }
  validates :description,
            presence: true,
            length: { maximum: 250 }
  validates :sphere,
            presence: true,
            length: { maximum: 15 }
  validates :location,
            presence: true,
            length: { maximum: 20 }
  validates :problem,
            presence: true,
            length: { maximum: 250 }
  validates :necessary,
            presence: true,
            length: { maximum: 250 }
  validates :team,
            presence: true,
            length: { maximum: 50 }
  validates :plans,
            presence: true,
            length: { maximum: 100 }

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
