class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :skype
      t.string :telephone
      t.integer :role, default: 1
      t.string :avatar

      t.string :country
      t.timestamps
    end
  end
end
