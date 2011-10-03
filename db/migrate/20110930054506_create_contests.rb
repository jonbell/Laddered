class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.integer :ladder_id, :null => false

      t.timestamps
    end

    add_index :contests, :ladder_id
  end
end
