class CreateLadders < ActiveRecord::Migration
  def change
    create_table :ladders do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end
end
