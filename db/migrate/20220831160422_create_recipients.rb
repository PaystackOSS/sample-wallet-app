class CreateRecipients < ActiveRecord::Migration[7.0]
  def change
    create_table :recipients do |t|
      t.string :name
      t.string :account
      t.string :bank_code
      t.string :recipient_code

      t.timestamps
    end
  end
end
