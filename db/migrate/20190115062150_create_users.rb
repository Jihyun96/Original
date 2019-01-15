class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :campus
      t.string :department
      t.integer :grade
      t.boolean :authority, default: false, null: false

      t.timestamps
    end
  end
end
