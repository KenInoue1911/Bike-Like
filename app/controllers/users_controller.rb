class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    # ユーザーがすでにルームに参加しているか判断
    @currentUserEntry = Entry.where(user_id: current_user.id)
    # ユーザー詳細ページのユーザーがルームに参加しているか判断
    @userEntry = Entry.where(user_id: @user.id)
    # @userとcurrent_userが違うユーザーか確認
    if @user.id == current_user.id
    else
      # current_userが参加してる全てのルームidを出力
      @currentUserEntry.each do |cu|
        # @userが参加してる全てのルームidを出力
        @userEntry.each do |u|
          # current_userの参加してるroom_idと@userのroom_idで一致するものがあるか
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      # isRoomがなかったら新規作成
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def index
    # gem ransackによる検索機能
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  # 退会画面
  def unsubscribe
     @user = User
  end

  # 退会機能
  def withdrawal
     @user = User.find(params[:id])
     @user.update(is_deleted: false)
     reset_session
     redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :gender, :profile, :bike, :is_deleted, :avater)
  end
end
