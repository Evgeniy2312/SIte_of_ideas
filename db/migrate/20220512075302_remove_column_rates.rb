class RemoveColumnRates < ActiveRecord::Migration[7.0]
  def change
    remove_column :rates, :amount, :integer
    remove_reference :rates, :user, foreign_key: true
  end
end
