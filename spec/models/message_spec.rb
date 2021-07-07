require 'rails_helper'

RSpec.describe 'Messageモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    
    context 'messageカラム' do
      it '空白でない' do
        message.message = ''
        is_expected.to eq false
      end
      it '100文字以内であること' do
        message.message = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end
end