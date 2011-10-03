class Ladder < ActiveRecord::Base
  validates :name, :presence => true

  has_many :users, :order => 'rank asc', :dependent => :destroy
  has_many :contests, :order => 'created_at desc', :dependent => :destroy

  def add_user(user)
    users_count = users.count
    if user.rank.nil? || user.rank > users_count + 1
      user.rank = users_count + 1
    elsif user.rank <= 0
      user.rank = 1
    end
    users.where("rank >= ?", user.rank).update_all("rank = rank + 1")
    user.save
  end

  def add_contest(user1, user1_score, user2, user2_score)
    contest = Contest.new(:ladder => self)
    Ladder.transaction do 
      contests << contest

      contest_score1 = ContestScore.new(
        :contest => contest,
        :user => user1,
        :score => user1_score,
        :pre_contest_rank => user1.rank
      )
      contest_score1.calc_result(user2_score)
      contest.contest_scores << contest_score1

      contest_score2 = ContestScore.new(
        :contest => contest,
        :user => user2,
        :score => user2_score,
        :pre_contest_rank => user2.rank
      )
      contest_score2.calc_result(user1_score)
      contest.contest_scores << contest_score2

      if user1.rank < user2.rank && user1_score < user2_score
        move_user(user2, user1.rank)
      elsif user2.rank < user1.rank && user2_score < user1_score
        move_user(user1, user2.rank)
      end
      contest_score1.update_attributes(:post_contest_rank => user1.reload.rank)
      contest_score2.update_attributes(:post_contest_rank => user2.reload.rank)
      user1.update_stats!(contest_score1)
      user2.update_stats!(contest_score2)
    end
    contest
  end

  def move_user(user, rank)
    return if user.rank == rank
    Ladder.transaction do
      if user.rank > rank
        users.where(:rank => rank..user.rank).update_all("rank = rank + 1")
      elsif user.rank < rank
        users.where(:rank => user.rank..rank).update_all("rank = rank - 1")
      end
      user.update_attributes(:rank => rank)
    end
  end
end
