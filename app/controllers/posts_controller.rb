class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.with_attached_image.order(created_at: :desc).page(params[:page]).per(5).includes(user: [avatar_attachment: :blob], comments: [user: [avatar_attachment: :blob]])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    # @post = Post.new(post_params)
    # @post.attributes = {
    #   user_id: current_user.id
    # }
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: '投稿を保存しました'
    else
      render :new
    end
  end

  def show 
    @post = Post.with_attached_image.includes(comments: [user: [ avatar_attachment: :blob ]]).find(params[:id])
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "投稿を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:caption, :new_image)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
