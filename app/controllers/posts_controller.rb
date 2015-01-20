class PostsController < ApplicationController
  
  # before_action :set_post_params, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show] #shut down routes if a user isn't logged in
  before_action :must_be_same_user, only: [:edit]
  
  helper_method :posts, :post, :comment
  
  def index
  end
  
  def new
  end
  
  def create
    post.creator = current_user    
    if post.save
      flash[:notice] = "You successfully created your post!"
      redirect_to posts_path
    else
      render :new
    end
  end
  
  def show
  end
  
  def edit; end
  
  def update
    if post.update(post_params)
      flash[:notice] = "You successfully edited your post!"
      redirect_to post_path(post)
    else
      render :edit
    end
  end
  
  
  private
  
  
  def post
    @post ||= begin
      case action_name
      when /new|create/
        Post.new(post_params)  
      else
        Post.find(params[:id]) # this is cached within Rails per action
      end
    end
  end
  
  def post_params
    if params[:post]
      params.require(:post).permit(:title, :url, :description, category_ids: [])
    else
      {}
    end
  end
  
  def must_be_same_user
    if current_user != @post.creator
      flash[:danger] = "You cannot edit another users post."
      redirect_to root_path
    end
  end
  
  def posts
    @posts ||= Post.most_voted
  end
  
  def comment
    @comment ||= Comment.new
  end
  
end
