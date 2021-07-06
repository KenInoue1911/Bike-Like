require 'rails_helper'

RSpec.describe 'Post_commentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post_comment.valid? }

    let(:user) { create(:user) }
    let!(:post_comment) { build(:post_comment, user_id: user.id) }
    
    context 'commentカラム' do
      it '空白でない' do
        post_comment.comment = ''
        is_expected.to eq false
      end
      it '100文字以内であること' do
        post_comment.comment = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end
  end
end