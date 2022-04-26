class Comment < ApplicationRecord

  belongs_to :idea

  validates :description, presence: true, length: { minimum: 1, maximum: 55 }
end
