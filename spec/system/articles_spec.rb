require 'rails_helper'

describe '画像投稿機能', type: :system do
  describe '一覧表示機能' do
    before do
      # ユーザーA作成
      user_a = FactoryBot.build(:user)
      # ユーザーAの投稿作成
      FactoryBot.build(:article, caption: '初投稿', user: user_a)
    end
    context '作成したユーザーがログインしている時' do
      before do
        # ユーザーAでログイン
      end

      it 'ユーザーAが作成した投稿が表示される' do
        # 作成済みの投稿が画面上に表示されていることを確認
      end
    end
  end
end
