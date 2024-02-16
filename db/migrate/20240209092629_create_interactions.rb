class CreateInteractions < ActiveRecord::Migration[7.0]
  def change
    create_table :interactions do |t|
      t.string :subject
      t.text :description
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end

