class HomesController < ApplicationController
  
  def top 
  end
  
  def about
  end
  
  def mypage
    @following_users = current_user.following_user
    @follower_users = current_user.follower_user
  end
  
  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com', name: 'ゲストユーザー', bike: 'スクーター', profile: 'ここは自己紹介です' ) do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
    sign_in user
    redirect_to posts_top_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
