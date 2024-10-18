class CreatePoints < ActiveRecord::Migration[7.1]
  def up
    create_table :points do |t|
      t.string "points"

      t.timestamps
    end
  end
  def down
    drop_table :points
  end
end
