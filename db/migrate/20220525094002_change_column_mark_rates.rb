class ChangeColumnMarkRates < ActiveRecord::Migration[7.0]
  def change
    change_column :rates, :mark, :float, default: 0
  end
end
