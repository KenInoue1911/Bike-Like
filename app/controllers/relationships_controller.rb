class RelationshipsController < ApplicationController
  before_action :move_to_signed_in
    # フォローする
    def create
      @user = User.find(params[:user_id])
      current_user.follow(params[:user_id])
    end
    
    # フォロー外す
    def destroy
      @user = User.find(params[:user_id])
      current_user.unfollow(params[:user_id])
    end
    
    # フォロー一覧画面
    def followings
      user = User.find(params[:user_id])
      @users = user.followings
    end
    
    # フォロワー一覧画面
    def followers
      user = User.find(params[:user_id])
      @users = user.followers
    end
    
    private
    
    def move_to_signed_in
      unless user_signed_in?
        # サインインしていないユーザーはログインページが表示される
        redirect_to '/users/sign_in'
      end
    end
end
