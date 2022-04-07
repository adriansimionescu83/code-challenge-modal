class AddNameFieldToInvitations < ActiveRecord::Migration[7.0]
  def change
    add_column :invitations, :display_name, :string
  end
end
