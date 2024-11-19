class AddColumnInUsersTable < ActiveRecord::Migration[7.1]
  def change
    change_column :users,:phone,:bigint
  end
end
