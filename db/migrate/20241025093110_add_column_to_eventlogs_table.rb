class AddColumnToEventlogsTable < ActiveRecord::Migration[7.1]
  def change
    add_column :eventlogs,:username,:string 
    add_column :eventlogs,:time,:datetime
    remove_column :eventlogs,:actions_id,:integer
  end
end
