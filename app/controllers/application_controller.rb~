class ApplicationController < ActionController::Base
  require 'digest/sha1'
  protect_from_forgery

  def not_found
      raise ActionController::RoutingError.new('Not Found')
  end
  
  def get_navigation args
    if args[:for] && args[:current]
      @nav = {}
      @nav[:next] = "Next >"
      @nav[:previous] = "< Previous"

      case args[:for]
      when 'posts'
        # Requires args[:archive] as the current page number
        # Some logic parameters:
        p = ( Post.last ? Post.last.id : 0 ) #Total Posts
        ppp = Post::POSTS_PER_PAGE  #Posts Per Page
        cp = args[:current] # Current first post
        
        @nav[:link_to_next] = ( cp - ppp > 0 ? ROOT_URL + "posts/archive/#{args[:archive]+1}" : false )
        @nav[:link_to_previous] = ( (p == 0 || cp == p) ? false : ROOT_URL + "posts/archive/#{args[:archive]-1}" )
        @nav[:title] = "Archive"
      when 'post'
        # Some logic parameters:
        p = ( Post.last ? Post.last : 0 ) #Total Posts
        cp = args[:current] # Current post

        @nav[:link_to_next] = ( cp.id == 1 ? false : ROOT_URL + "posts/#{cp.id - 1}" )
        @nav[:link_to_previous] = ( cp === p ? false : ROOT_URL + "posts/#{cp.id + 1}" )
        @nav[:title] = cp.strf_release
      when 'videos'
        # Requires args[:video] as the current video object
        # Some logic parameters:
        video = args[:current] #current video object
        url_id = params[:id].to_i
        url_post_id = params[:post_id].to_i
        # Assumes Three Videos Posted in a day
        @nav[:link_to_next] = ( (video.id == 3) ? false : ROOT_URL + "posts/#{(url_id == 3 ? url_post_id - 1 : url_post_id)}/videos/#{(url_id.modulo 3) + 1}" )
        @nav[:link_to_previous] = ( (Video.last.id - 2 == video.id ) ? false : ROOT_URL + "posts/#{(url_id == 1 ? url_post_id + 1 : url_post_id)}/videos/#{((url_id - 2).modulo 3) + 1}" )
        @nav[:title] = video.title
      else
        @nav = false
      end
      return @nav
    else
      raise "Required arguments for PostController#get_navigation not received.  Required arguments: :for and :current."
    end
  end

  def get_menu args
    if args[:for]
      @menu = {}
      case args[:for]
      when 'post'
        @menu[:rel] = 'post'
        @menu[:items] = [{:text => 'Archive', :href => ROOT_URL + 'posts/archive/0'}]
      when 'video'
        @menu[:rel] = 'video'
        @menu[:items] = [ {:text => 'Archive', :href => ROOT_URL + 'posts/archive/0'}, {:text => args[:post].strf_release( :short => true ), :href => ROOT_URL + "posts/#{args[:post].id}"}  ]
      end
    end
    return @menu
  end

  def get_background_for post
    post ? Background.where("post_id = ?", post.id).first : Background::DEFAULT
  end

  def get_random_background args = nil
    if args && args[:for]
      posts = args[:for]
      background = get_background_for posts[ rand( posts.length-1 ) ]
    else
      background = get_background_for Post.find( rand(Post.last.id) )
    end
    return background
  end
  
  def encrypt password
    salt = 'WekUz7J1TM'
    password += salt
    Digest::SHA1.hexdigest password
  end

  def encrypted_password
    '7d7fccacf529e1e5b6c7bbf5184fa0908eaf429c'
  end

end
