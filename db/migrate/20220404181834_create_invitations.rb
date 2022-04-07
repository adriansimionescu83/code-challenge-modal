class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.string :email, null: false
      t.string :message
      t.references :cycle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
