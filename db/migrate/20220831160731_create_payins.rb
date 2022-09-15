class CreatePayins < ActiveRecord::Migration[7.0]
  def change
    create_table :payins do |t|
      t.integer :amount
      t.date :date
      t.string :ref

      t.timestamps
    end
  end
end
