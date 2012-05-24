class ApplicationController < ActionController::Base
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
        @nav[:title] = "Recent Videos"
      when 'videos'
        # Requires args[:video] as the current video object
        # Some logic parameters:
        video = args[:current] #current video object
        url_id = params[:id].to_i
        url_post_id = params[:post_id].to_i
        flash[:debug] = Video.first.id.to_s + ' and ' + video.id.to_s
        @nav[:link_to_next] = ( ( Video.last && (Video.last.id == video.id) ) ? false : ROOT_URL + "posts/#{(url_id == 3 ? url_post_id + 1 : url_post_id)}/videos/#{(url_id.modulo 3) + 1}" )
        @nav[:link_to_previous] = ( (Video.first && (Video.first.id == video.id) ) ? false : ROOT_URL + "posts/#{(url_id == 1 ? url_post_id - 1 : url_post_id)}/videos/#{((url_id - 2).modulo 3) + 1}" )
        @nav[:title] = video.title
      else
        @nav = false
      end
      return @nav
    else
      raise "Required arguments for PostController#get_navigation not received.  Required arguments: :for and :current."
    end
  end

end
