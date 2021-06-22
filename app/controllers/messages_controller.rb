class MessagesController < ApplicationController
  before_action :move_to_signed_in
    # DMのメッセージ機能

    # メッセージを作成
    def create
      # :messageと:room_idが入っているか確認
      Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(message_params)
      @message.save!
    end

    # ストロングパラメーター
    private

    def message_params
      params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
    end

    def move_to_signed_in
      unless user_signed_in?
        # サインインしていないユーザーはログインページが表示される
        redirect_to '/users/sign_in'
      end
    end
end
