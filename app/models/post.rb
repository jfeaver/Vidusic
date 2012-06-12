class Post < ActiveRecord::Base
  has_many :videos
  has_one :background

  #accepts_nested_attributes_for :videos, :background, :allow_destroy => true

  validates :release, :presence => true

  def self.recent offset = 0
    n = Post::POSTS_PER_PAGE # n => number of posts to display per page
    posts = Post.order("release DESC").offset(offset).limit(n).all
    if posts.length == 0
      if offset == 0
        return false
      else
        # The end of the archive pages has been surpassed => Return a last page number for redirect:
        last_post_id = Post.order("release ASC").limit(n).last.id
        return last_post_id.modulo n
      end
    else
      return posts
    end
  end

  POSTS_PER_PAGE = 12

  def self.next_release
    recent_release_date = ( Post.last ? Post.last.release : Date.today - 1 )
    return ( recent_release_date < Date.today ? Date.today : recent_release_date + 1 )
  end
end
