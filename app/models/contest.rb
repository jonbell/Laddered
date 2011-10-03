class Contest < ActiveRecord::Base
  belongs_to :ladder
  has_many :contest_scores, :order => 'score desc', :dependent => :destroy

  accepts_nested_attributes_for :contest_scores
end
