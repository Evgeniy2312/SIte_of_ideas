class Tag < ApplicationRecord
  has_and_belongs_to_many :ideas, -> { distinct }, foreign_key: 'tag_id'
end
