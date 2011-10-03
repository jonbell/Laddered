class AddRankToContestScore < ActiveRecord::Migration
  def change
    add_column :contest_scores, :pre_contest_rank, :integer
    add_column :contest_scores, :post_contest_rank, :integer
  end
end
