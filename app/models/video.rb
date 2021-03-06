class Video < ActiveRecord::Base
  belongs_to :post

  validates :slug, :presence => true, :uniqueness => true, :format => { :with => /^(\w|-){11}$/, :message => 'is invalid.  Use 11 letters, numbers, or underscores' }
  validates :title, :presence => true, :length => { :in => 3..30, :message => 'is too long or too short' }

  def self.get_for posts
    if posts.respond_to?(:each)
      videos = []
      posts.each do |post|
        videos << Video.where(["post_id = ?", post.id]).all
      end
    else
      # only one post in posts
      videos = (Video.exists?(posts.id) ? Video.where(["post_id = ?", posts.id]).all : false)
    end
    videos
  end

end
