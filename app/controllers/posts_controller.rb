class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def index
    # gem ransackによる検索機能
    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(:user).page(params[:page])
    # tag付け
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = PostComment.page(params[:page]).per(3)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  if @post.user == current_user
  else
    redirect_to post_path(@post.id)
  end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def top
    # 3つまでお気に入りの多い順に記事を表示
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  def favorite
    @favorites = Favorite.where(user_id: current_user.id)
  end

   # 投稿データのストロングパラメータ
  private

  def post_params
    params.require(:post).permit(:title, :image, :post_profile, :post_bike, :tag_list)
  end
end
