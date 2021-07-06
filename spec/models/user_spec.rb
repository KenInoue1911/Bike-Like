require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空白でないこと' do
        user.name = ''
      end
      it '9文字以下であること' do
        user.name = Faker::Lorem.characters(number: 10)
        is_expected.to eq false
      end
      it '自己紹介は200文字以下であること' do
        user.profile = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end
end