class UsersController < InheritedResources::Base
  belongs_to :ladder

  def create
    create! do
      return redirect_to ladder_path(@ladder)
    end
  end

  def create_resource(object)
    @ladder.add_user(object)
  end

  def show
    show! do
      @last_10_results = @user.contest_scores.by_latest.limit(10).all
    end
  end
end
