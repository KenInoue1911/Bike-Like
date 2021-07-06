require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }

    context 'titleカラム' do
      it '空白でない' do
        post.title = ''
      end
      it '15文字以内であること' do
        post.title = Faker::Lorem.characters(number: 16)
        is_expected.to eq false
      end
    end

    context 'post_bikeカラム' do
      it '空白でない' do
        post.post_bike = ''
      end
      it '8文字以内である' do
        post.post_bike = Faker::Lorem.characters(number: 9)
        is_expected.to eq false
      end
    end

    context 'post_profileカラム' do
      it '空白でない' do
        post.post_profile = ''
      end
      it '200文字以内である' do
        post.post_profile = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end

    context "画像" do
      it '画像が空白でないか' do
        post.image = ''
        is_expected.to eq false
      end
    end

    end
  end