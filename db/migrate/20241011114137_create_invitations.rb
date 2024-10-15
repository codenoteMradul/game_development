class CreateInvitations < ActiveRecord::Migration[7.1]
  def up
    create_table :invitations do |t|
      t.string "email"
      t.belongs_to "user" 
      t.timestamps
    end
  end
end
