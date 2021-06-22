class RoomsController < ApplicationController
   before_action :move_to_signed_in
    # DMのチェットルームのコントローラー

    # チャットルーム一覧画面
    def index
      # ルームの一覧表示新しい順
      @rooms = current_user.rooms.joins(:messages).includes(:messages).order('messages.created_at DESC')
    end

    # チャットルーム
    def show
      @room = Room.find(params[:id])
      # entryテーブルに情報があるか確認
      if Entry.where(user_id: current_user.id, room_id: @room.id).present?
        # メッセージを上から新しい順に表示
         @messages = @room.messages.order(id: 'desc').limit(7)
         @message = Message.new
        # entriesにroomに参加してるユーザーを取得
         @entries = @room.entries
      else
         redirect_back(fallback_location: root_path)
      end
    end

    # チャットルーム作成
    def create
      @room = Room.create
      # current_userのidと新しくできたroomのidを保存
      @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
      # @userの情報をidへ代入。そこに新しくできたroom_idをmergeして登録する。
      @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
      redirect_to "/rooms/#{@room.id}"
    end

    private

    def move_to_signed_in
      unless user_signed_in?
        # サインインしていないユーザーはログインページが表示される
        redirect_to '/users/sign_in'
      end
    end
end
