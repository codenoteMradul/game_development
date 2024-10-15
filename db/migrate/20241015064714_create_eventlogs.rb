class CreateEventlogs < ActiveRecord::Migration[7.1]
  def up
   create_table :eventlogs do |t| 
    t.string "actions"
    t.integer "actions_id"
    t.belongs_to "user"

    t.timestamps
   end
 end

  def down
   drop_table :eventlogs
  end
end
