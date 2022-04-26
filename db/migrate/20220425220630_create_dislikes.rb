class CreateDislikes < ActiveRecord::Migration[7.0]
  def change
    create_table :dislikes do |t|
      t.belongs_to :idea, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
