require 'rails_helper'

RSpec.describe 'ログイン・ログアウト', type: :system do
  let(:user) { create(:user) }

  describe 'モーダル' do
    describe 'ログイン' do
      it '「新規作成する」ボタンを押すと新規登録画面へ遷移すること' do
        visit '/'
        click_button 'ログイン'
        click_button '新規作成する'
        Capybara.assert_current_path("/users/new", ignore_query: true)
        expect(current_path).to eq '/users/new', 'ユーザー新規作成画面に遷移していません'
      end

      context '認証情報が正しい場合' do
        it 'ログインできること' do
          visit '/'
          click_button 'ログイン'
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'password'
          click_button 'ログイン'
          Capybara.assert_current_path("/home", ignore_query: true)
          expect(current_path).to eq '/home'
          expect(page).to have_content('ログインしました'), 'フラッシュメッセージ「ログインしました」が表示されていません'
        end
      end

      context 'PWに誤りがある場合' do
        it 'ログインできないこと' do
          visit '/'
          click_button 'ログイン'
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'pass'
          click_button 'ログイン'
          Capybara.assert_current_path("/login", ignore_query: true)
          expect(current_path).to eq('/login'), 'ログイン失敗時にログイン画面に戻ってきていません'
          expect(page).to have_content('ログインに失敗しました'), 'フラッシュメッセージ「ログインに失敗しました」が表示されていません'
        end
      end
    end
  end
  describe '通常画面' do
    describe 'ログイン' do
      it '正しいタイトルが表示されていること' do
        visit '/login'
        expect(page).to have_title("ログイン - app_name"), 'ログインページのタイトルに「ログイン - app_name」が含まれていません。'
      end

      it '「新規作成する」ボタンを押すと新規登録画面へ遷移すること' do
        visit '/login'
        click_button '新規作成する'
        Capybara.assert_current_path("/users/new", ignore_query: true)
        expect(current_path).to eq '/users/new', 'ユーザー新規作成画面に遷移していません'
      end

      context '認証情報が正しい場合' do
        it 'ログインできること' do
          visit '/login'
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'password'
          click_button 'ログイン'
          Capybara.assert_current_path("/home", ignore_query: true)
          expect(current_path).to eq '/home'
          expect(page).to have_content('ログインしました'), 'フラッシュメッセージ「ログインしました」が表示されていません'
        end
      end

      context 'PWに誤りがある場合' do
        it 'ログインできないこと' do
          visit '/login'
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'pass'
          click_button 'ログイン'
          Capybara.assert_current_path("/login", ignore_query: true)
          expect(current_path).to eq('/login'), 'ログイン失敗時にログイン画面に戻ってきていません'
          expect(page).to have_content('ログインに失敗しました'), 'フラッシュメッセージ「ログインに失敗しました」が表示されていません'
        end
      end
    end
  end
  describe 'ログアウト' do
    before do
      login_as(user)
    end

    it 'ログアウトできること' do
      find('#user-menu-button').click
      click_on('ログアウト')
      Capybara.assert_current_path("/", ignore_query: true)
      expect(current_path).to eq root_path
      expect(page).to have_content('ログアウトしました'), 'フラッシュメッセージ「ログアウトしました」が表示されていません'
    end
  end
end
