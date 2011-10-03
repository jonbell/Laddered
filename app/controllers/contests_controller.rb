class ContestsController < InheritedResources::Base
  belongs_to :ladder

  def new
    new! do
      scores = User.order('rank asc').find(params[:user_id]).map do |user|
        ContestScore.new(:user => user, :contest => @contest)
      end
      @contest.contest_scores = scores
    end
  end

  def create
    create! do
      return redirect_to ladder_path(@ladder)
    end
  end

  def create_resource(contest)
    score1, score2 = contest.contest_scores
    @ladder.add_contest(score1.user, score1.score, score2.user, score2.score)
  end
end
