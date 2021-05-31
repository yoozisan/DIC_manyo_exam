require 'rails_helper'
RSpec.describe 'ユーザー登録機能', type: :system do
  # before do
  #   binding.irb
  #   let!(:user){FactoryBot.create(:user)}
  #   let!(:user){FactoryBot.create(:admin_user)}
  #   visit new_session_path
  # end
  describe 'ユーザー登録テスト' do
    context 'ユーザー新規作成時' do
      it '作成したユーザーが表示される' do
        visit new_user_path
        fill_in "名前", with: "test_user"
        fill_in "メールアドレス", with: "test@test.com"
        fill_in "パスワード", with: "password"
        fill_in "確認用パスワード", with: "password"
        click_on 'Create my account'
        fill_in "Email", with: "test@test.com"
        fill_in "Password", with: "password"
        click_on 'Log in'
        # binding.irb
        expect(page).to have_content 'test_user'
        expect(page).to have_content 'test@test.com'
      end
    end
    context 'ログインせずにタスク一覧画面に飛んだ場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content "Log in"
        expect(page).to have_content "Email"
        expect(page).to have_content "Password"
        expect(current_path).to have_content "/sessions/new"
      end
    end
  end
  describe 'セッション機能のテスト ' do
    context 'ログインした場合' do
      it '作成したユーザーが表示される' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in "Email", with: "user1@user1.com"
        fill_in "Password", with: "111111"
        within '.actions' do
          click_on 'Log in'
        end
        expect(page).to have_content 'user1'
        expect(page).to have_content 'user1@user1.com'
      end
    end
    context '自分の詳細画面に飛んだ場合' do
      it '自分の詳細ページに遷移する' do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "Email", with: "user1@user1.com"
        fill_in "Password", with: "111111"
        within '.actions' do
          click_on 'Log in'
        end
        # binding.irb
        click_on 'タスク一覧'
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログアウトした場合' do
      it 'ログイン画面に遷移する' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in "Email", with: "user1@user1.com"
        fill_in "Password", with: "111111"
        within '.actions' do
          click_on 'Log in'
        end
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
        expect(page).to have_content 'Log in'
      end
    end
  end
  describe '管理画面のテスト ' do
    context '管理ユーザーが管理画面にアクセスした場合' do
      it '管理画面に遷移する' do
        user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "Email", with: "user2@user2.com"
        fill_in "Password", with: "222222"
        within '.actions' do
          click_on 'Log in'
        end
        click_on '管理者画面'
        expect(page).to have_content '管理者画面：ユーザー一覧'
      end
    end
    context '一般ユーザーが管理画面にアクセスした場合' do
      it 'タスク一覧画面に遷移する' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in "Email", with: "user1@user1.com"
        fill_in "Password", with: "111111"
        within '.actions' do
          click_on 'Log in'
        end
        visit admin_users_path
        expect(page).to have_content '管理者画面は、管理者以外アクセス不可'
        expect(page).to have_content 'タスク一覧'
      end
    end
    context '管理ユーザーが管理画面でユーザーの新規登録をした場合' do
      it '管理画面のユーザー詳細ページに遷移する' do
        user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "Email", with: "user2@user2.com"
        fill_in "Password", with: "222222"
        within '.actions' do
          click_on 'Log in'
        end
        visit admin_users_path
        click_on '新しくユーザーを作成する'
        fill_in "名前", with: "test_user"
        fill_in "メールアドレス", with: "test@test.com"
        fill_in "パスワード", with: "password"
        fill_in "確認用パスワード", with: "password"
        click_on '登録する'
        expect(page).to have_content 'ユーザー情報を登録しました'
        expect(page).to have_content '管理者画面：ユーザー情報詳細'
      end
    end
    context '管理ユーザーが管理画面でユーザーの詳細ページに飛んだ場合' do
      it 'ユーザーの詳細ページに遷移する' do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:admin_user)
        visit new_session_path
        # binding.irb
        fill_in "Email", with: "user2@user2.com"
        fill_in "Password", with: "222222"
        within '.actions' do
          click_on 'Log in'
        end
        visit admin_users_path
        visit admin_user_path(user1.id)
        # binding.irb
        expect(page).to have_content '管理者画面：ユーザー情報詳細'
        expect(page).to have_content 'user1'
      end
    end
    context '管理ユーザーが管理画面でユーザーの編集ページに飛んだ場合' do
      it 'ユーザーの編集ページで情報編集ができる' do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "Email", with: "user2@user2.com"
        fill_in "Password", with: "222222"
        within '.actions' do
          click_on 'Log in'
        end
        visit admin_users_path
        visit edit_admin_user_path(user1.id)
        fill_in "名前", with: "edit_user"
        fill_in "メールアドレス", with: "edit@edit.com"
        fill_in "パスワード", with: "password_edit"
        fill_in "確認用パスワード", with: "password_edit"
        click_on '更新する'
        expect(page).to have_content 'ユーザー情報を編集しました'
        expect(page).to have_content '管理者画面：ユーザー情報詳細'
        expect(page).to have_content 'edit_user'
      end
    end
    context '管理ユーザーが管理画面でユーザーの削除ボタンを押した場合' do
      it 'ユーザーの削除ができる' do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "Email", with: "user2@user2.com"
        fill_in "Password", with: "222222"
        within '.actions' do
          click_on 'Log in'
        end
        # binding.irb
        visit admin_users_path
        within 'ul li:first-child' do
          page.accept_confirm do #確認画面のボタンを押すため
            click_on 'ユーザー情報を削除する'
          end
        end
        expect(page).to have_content 'ユーザー情報を削除しました'
      end
    end
  end
end
