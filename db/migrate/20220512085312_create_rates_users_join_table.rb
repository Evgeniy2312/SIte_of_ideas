class CreateRatesUsersJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :rates do |t|
      t.index :user_id
      t.index :rate_id
    end
  end
end
