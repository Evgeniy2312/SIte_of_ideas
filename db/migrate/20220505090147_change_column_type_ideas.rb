class ChangeColumnTypeIdeas < ActiveRecord::Migration[7.0]
  def change
    change_column :ideas, :team, :string
  end
end
