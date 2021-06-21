class PostsController < ApplicationController
before_action :move_to_signed_in
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
       redirect_to posts_path
    else
      render :new
    end
  end

  def index
    # gem ransackによる検索機能
    @q = Post.ransack(params[:q])
    @q.sorts = 'updated_at desc' if @q.sorts.empty?
    @posts = @q.result.includes(:user).page(params[:page])

    # tag付け
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.order(id: 'desc').page(params[:page]).per(3)
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
  if @post.update(post_params)
     redirect_to post_path(@post.id)
  else
    render :edit
  end
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
    def move_to_signed_in
    unless user_signed_in?
      #サインインしていないユーザーはログインページが表示される
      redirect_to  '/users/sign_in'
    end
  end

  def post_params
    params.require(:post).permit(:title, :image, :post_profile, :post_bike, :tag_list)
  end
end
