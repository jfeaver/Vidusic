class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  # Home page!
  def index
    @posts = Post.recent
    
    #@nav[:next] = Post.posts_to_display
    #@nav = [:link_to_next, :next, :previous, :link_to_previous, :title]
    @nav = get_navigation :for => 'posts', :current => ( Post.last ? Post.last.id : 0 ), :archive => 0
    @background = get_latest_background #Background::DEFAULT
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def archive
    page_num = params[:page].to_i
    offset = page_num * Post::POSTS_PER_PAGE
    @posts = Post.recent( offset )
    if @posts.respond_to? :integer?
      # The end of the archive pages has been surpassed
      redirect_to( :action => :archive, :page => @posts )
    else
      @nav = get_navigation :for => 'posts', :current => @posts[0].id, :archive => page_num
      @background = get_background_for @posts[rand( 0..(@posts.length-1) )]
      render( "index" )
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @videos = Video.where(["post_id = ?", params[:id]]).all
    @background = get_background_for @post #Background::DEFAULT #Background.where(["post_id = ?", params[:id]])

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
    @new_background = Background.new

    @background = get_latest_background

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

    # Create a new post but don't save yet
    params[:post] = Hash[ :release, Post.next_release ]
    @post = Post.new(params[:post])

    # Setup
    video = nil
    background = nil
    errors = []
    
    # Create Videos
    3.times do |video_counter|
      video_counter = video_counter.to_s
      unless params[:video][video_counter].empty?
        post_id = (Post.last ? Post.last.id + 1 : 1 )
        params[:video][video_counter][:post_id] = post_id
        @video = Video.new(params[:video][video_counter])
        video = true if @video.save && video.nil?
        unless @video.errors.empty?
          errors << @video.errors
          video = false
        end
      end
    end

    # Create Background
    unless params[:background].empty?
      post_id = (Post.last ? Post.last.id + 1 : 1 ) unless post_id
      params[:background][:post_id] = post_id
      @new_background = Background.new(params[:background])
      if @new_background.save
        background = true
      else
        errors << @new_background.errors
        background = false
      end
    end
    
    @background = get_latest_background

    respond_to do |format|
      if @post.save && ( background || background.nil? ) && ( video || video.nil? )
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        flash[:notice] = errors.inspect
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
    @videos = Video.where(["post_id = ?", params[:id]]).all
    @background = get_background_for @post
    
    @post.destroy
    @videos.each { |video| video.destroy }
    @background.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
