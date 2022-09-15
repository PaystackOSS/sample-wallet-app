class ChangeBalance < ActiveRecord::Migration[7.0]
  def change
    change_column :wallets, :balance, :integer, default: 0_00
  end
end
