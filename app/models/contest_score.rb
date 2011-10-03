class ContestScore < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest

  validates :result, :inclusion => { :in => %w{win loss tie}, :message => "%{value} is not a valid result"}

  scope :wins, where(:result => 'win')
  scope :losses, where(:result => 'loss')
  scope :ties, where(:result => 'tie')

  scope :by_latest, joins(:contest).order('contests.created_at DESC')
  scope :not, ->(score) { where('id != ?', score.id) }

  def calc_result(other_score)
    self.result = if score > other_score
      'win'
    elsif score < other_score
      'loss'
    else
      'tie'
    end
  end

  def competitor
    @competitor_score ||= contest.contest_scores.not(self).first
  end

  def full_score
    "#{score}-#{competitor.score}"
  end
end
