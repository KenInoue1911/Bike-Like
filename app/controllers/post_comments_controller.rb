class PostCommentsController < ApplicationController

    def create
      @post = Post.find(params[:post_id])
      @post_comment = PostComment.new(post_comment_params)
      @post_comment.post_id = @post.id
      @post_comment.user_id = current_user.id
      @post_comment.save
      # コメントを上から新しい順に perでコメントの最大表示件数
      @post_comments = @post.post_comments.order(id: 'desc').page(params[:page]).per(5)
      @page = params[:page]
    end

    def destroy
      @post = Post.find(params[:post_id])
      post_comment = PostComment.find(params[:id])
      post_comment.destroy
      @post_comments = @post.post_comments.order(id: 'desc').page(params[:page]).per(5)
      @post_comment = PostComment.new
    end

    private

    def post_comment_params
      params.require(:post_comment).permit(:comment)
    end
end
