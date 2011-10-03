class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :ladder_id, :null => false
      t.string :name, :null => false
      t.integer :rank, :null => false
      t.integer :wins, :default => 0
      t.integer :losses, :default => 0
      t.timestamps
    end

    add_index :users, :ladder_id
  end
end
