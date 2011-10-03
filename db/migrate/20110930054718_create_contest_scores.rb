class CreateContestScores < ActiveRecord::Migration
  def change
    create_table :contest_scores do |t|
      t.integer :contest_id, :null => false
      t.integer :user_id, :null => false
      t.integer :score, :null => false
      t.string :result, :null => false
    end

    add_index :contest_scores, :contest_id
    add_index :contest_scores, :user_id
  end
end
