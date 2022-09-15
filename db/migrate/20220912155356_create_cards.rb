class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :auth_code
      t.string :last_4
      t.string :brand
      t.string :bank
      t.references :user, index: true
      t.timestamps
    end
  end
end
