class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  # Home page!
  def index
    @posts = Post.recent
    
    #@nav[:next] = Post.posts_to_display
    #@nav = [:link_to_next, :next, :previous, :link_to_previous, :title]
    @nav = get_navigation_for 0      
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def archive
    page_num = params[:page].to_i
    @nav = get_navigation_for page_num 
    offset = page_num * Post.posts_to_display
    @posts = Post.recent( offset )
    @posts.respond_to?(:integer?) ? redirect_to( :action => :archive, :page => @posts ) : render( "index" )

  end

  private
  
  def get_navigation_for page
    @nav = {}
    @nav[:next] = "Next >"
    @nav[:previous] = "< Previous"
    @nav[:link_to_next] = ROOT_URL + "posts/archive/#{page+1}"
    @nav[:link_to_previous] = ROOT_URL + "posts/archive/#{page-1}"
    @nav[:title] = "Recent Videos"
    @nav
  end

  public

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @video = Video.new
    @background = Background.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    video = nil
    background = nil
    errors = []
    if params[:video]
      @video = Video.new(params[:video])
      if @video.save
        video = true
      else
        errors << @video.errors
        video = false
      end
    end
    if params[:background]
      @background = Background.new(params[:background])
      if @background.save
        background = true
      else
        errors << @background.errors
        background = false
      end
    end
    
    respond_to do |format|
      if @post.save && ( background || background.nil? ) && ( video || video.nil? )
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        errors << @post.errors
        format.html { render action: "new" }
        format.json { render json: errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
