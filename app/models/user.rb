class User < ActiveRecord::Base
  belongs_to :ladder
  has_many :contest_scores, :dependent => :destroy

  validates :name, :presence => true

  def current_streak_short
    return 'N/A' unless current_streak_type
    current_streak_type[0].upcase + current_streak_length.to_s
  end

  def total_wins
    contest_scores.wins.count
  end

  def total_losses
    contest_scores.losses.count
  end

  def total_ties
    contest_scores.ties.count
  end

  def next_user
    @next_user ||= ladder.users.detect{|u| u.rank == rank + 1}
  end

  def update_stats!(score)
    if score.result != 'tie'
      if current_streak_type && current_streak_type == score.result
        self.current_streak_length += 1
      else
        self.current_streak_type = score.result
        self.current_streak_length = 1
      end

      all_time_streak_key = streak_key(score.result)
      if current_streak_length > self.send(all_time_streak_key) then
        self.send("#{all_time_streak_key}=", current_streak_length)
      end
    end
    self.win_pct = self.contest_scores.where(:result => 'win').count * 1.0 / self.contest_scores.count
    
    self.wins_on_top += 1 if score.result == 'win' && rank == 1

    save!
  end

  private

  def streak_key(result)
    middle = case result
    when 'win' then 'winning'
    when 'loss' then 'losing'
    else nil
    end

    "longest_#{middle}_streak"
  end
end