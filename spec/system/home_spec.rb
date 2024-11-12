require 'rails_helper'

describe 'トップページ', type: :system do
  describe '画面表示' do
    it '正しいタイトルが表示されていること' do
      visit '/'
      expect(page).to have_title("TOP - app_name"), 'TOPページのタイトルに「TOP - app_name」が含まれていません。'
    end

    it 'ログインボタンを押すとモーダルが出ること' do
      visit '/'
      click_button 'ログイン'
      expect(page).to have_content('メールアドレス'), 'ログインモーダルが表示されていません'
    end
  end
end
