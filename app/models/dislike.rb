class Dislike < ApplicationRecord
  belongs_to :idea, foreign_key: 'idea_id'
  belongs_to :user, foreign_key: 'user_id'

end
