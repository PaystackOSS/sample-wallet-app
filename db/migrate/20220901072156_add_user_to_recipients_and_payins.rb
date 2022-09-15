class AddUserToRecipientsAndPayins < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipients, :user, index: true
    add_reference :payins, :user, index: true
  end
end