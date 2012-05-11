class Post < ActiveRecord::Base
  has_many :videos
  has_one :background

  validates :release, :presence => true

  def self.recent offset = 0
    n = Post.posts_to_display # n => number of posts to display per page
    posts = Post.order("release DESC").offset(offset).limit(n).all
    if posts.length == 0
      last_post_id = Post.order("release ASC").limit(n).last.id
      return last_post_id.modulo n
    end
    posts
  end

  def self.posts_to_display
    2
  end
end
