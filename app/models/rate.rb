class Rate < ApplicationRecord
  belongs_to :idea, foreign_key: 'idea_id'
  has_and_belongs_to_many :users, foreign_key: 'rate_id'

  validates :mark,
            presence: true
end
