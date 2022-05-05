class CreateIdeas < ActiveRecord::Migration[7.0]
  def change
    create_table :ideas do |t|
      t.string :name
      t.integer :access, null: false, default: 1
      t.text :description
      t.string :sphere
      t.string :location
      t.text :plans
      t.string :problem
      t.string :necessary
      t.json :team
      t.timestamps
    end
  end
end
