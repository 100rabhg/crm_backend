class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :phone_number
      t.string :address
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
