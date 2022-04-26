class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :description
      t.belongs_to :idea, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
