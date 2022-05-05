class CreateIdeasTagsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :ideas, :tags do |t|
      t.index :tag_id
      t.index :idea_id
    end
  end
end
