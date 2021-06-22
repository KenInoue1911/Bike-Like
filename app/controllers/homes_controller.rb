class HomesController < ApplicationController
  
    def top
      
    end
    
    def about
      
    end
    
      #ゲストユーザー作成
    def guest_sign_in
        #ゲストユーザーのメールアドレスと名前の作成
        user = User.find_or_create_by!(email: 'guest@example.com', name: 'ゲストユーザー') do |user|
        #パスワードのランダム化
        user.password = SecureRandom.urlsafe_base64
    end
      sign_in user
      redirect_to posts_top_path, notice: 'ゲストユーザーとしてログインしました。'
    end
end
