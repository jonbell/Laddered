class AddUserStatistics < ActiveRecord::Migration
  def change
    add_column :users, :current_streak_type, :string
    add_column :users, :current_streak_length, :integer, :default => 0
    add_column :users, :longest_winning_streak, :integer, :default => 0
    add_column :users, :longest_losing_streak, :integer, :default => 0
    add_column :users, :win_pct, :float, :default => 0.0
    add_column :users, :wins_on_top, :integer, :default => 0
  end
end
