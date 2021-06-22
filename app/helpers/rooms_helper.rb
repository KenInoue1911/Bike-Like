module RoomsHelper
    # 最新メッセージのデータを取得して表示するメソッド
    def most_new_message_preview(room)
      # 最新メッセージのデータを取得する
      message = room.messages.order(updated_at: :desc).limit(1)
      # 配列から取り出す
      message = message[0]
      # メッセージの有無を判定
    if message.present?
        # メッセージがあれば内容を表示
      tag.p message.message.to_s, class: 'dm_list__content__link__box__message'
    else
        # メッセージがなければまだ[メッセージはありません]を表示
      tag.p '[ まだメッセージはありません ]', class: 'dm_list__content__link__box__message'
    end
    end
  
    # 相手ユーザー名を取得して表示するメソッド
    def opponent_user(room)
      # 中間テーブルから相手ユーザーのデータを取得
      entry = room.entries.where.not(user_id: current_user)
      # 相手ユーザーの名前を取得
      name = if entry[0].blank?
        'ユーザーは退会しました。'
      else
      entry[0].user.name
      end
      # 名前を表示
      tag.p name.to_s, class: 'dm_list__content__link__box__name'
    end
end
