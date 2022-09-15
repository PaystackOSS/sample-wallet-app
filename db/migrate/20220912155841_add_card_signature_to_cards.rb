class AddCardSignatureToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :signature, :string, unique: true
  end
end
