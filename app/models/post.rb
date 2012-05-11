class Post < ActiveRecord::Base
  has_many :videos
  has_one :background

  validates :release, :presence => true

  def self.recent videos
    Post.order("release DESC").limit(videos).all
  end
end
