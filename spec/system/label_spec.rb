require 'rails_helper'
RSpec.describe 'ラベル登録機能', type: :system do
  # let!(:user) { FactoryBot.create(:user)}
  before do
    @user = FactoryBot.create(:user)
    visit new_session_path
    fill_in "Email", with: "user1@user1.com"
    fill_in "Password", with: "111111"
    within '.actions' do
      click_on 'Log in'
    end
  end
  describe 'ラベル登録のテスト' do
    context 'タスク作成時にラベルを選択した場合' do
      it 'タスクにラベルが紐づいて表示される' do
        FactoryBot.create(:label)
        # FactoryBot.create(:label2)
        # FactoryBot.create(:label3)
        visit new_task_path
        fill_in "タスク名", with: "task_name"
        fill_in "内容", with: "task_content"
        find("#task_expired_at_1i").find("option[value='2021']").select_option
        find("#task_expired_at_2i").find("option[value='6']").select_option
        find("#task_expired_at_3i").find("option[value='3']").select_option
        find("#task_expired_at_4i").find("option[value='06']").select_option
        find("#task_expired_at_5i").find("option[value='03']").select_option
        find("#task_status_name").find("option[value='着手']").select_option
        find("#task_priority").find("option[value='高']").select_option
        check 'ルンピニー'
        page.accept_confirm do
          click_on '登録する'
        end
        expect(page).to have_content 'task_name'
        expect(page).to have_content 'ルンピニー'
      end
    end
    context 'タスク編集時にラベルを別のものにした場合' do
      it '変更したタスクにラベルが紐づいて表示される' do
        # FactoryBot.create(:label)
        FactoryBot.create(:label2)
        FactoryBot.create(:label3)
        task2 = FactoryBot.create(:task2, user_id: @user.id)
        visit edit_task_path(task2.id)
        check 'ヨッカオ'
        uncheck 'トップキング'
        page.accept_confirm do
          click_on '登録する'
        end
        expect(page).to have_content 'task2'
        expect(page).to have_content 'ヨッカオ'
      end
    end
  end
  describe 'ラベル検索のテスト' do
    context 'ラベル名で検索した場合' do
      it '選択したラベルのついたタスクが表示される' do
        FactoryBot.create(:label)
        FactoryBot.create(:label2)
        FactoryBot.create(:label3)
        visit new_task_path
        fill_in "タスク名", with: "task_name1"
        fill_in "内容", with: "task_content1"
        find("#task_expired_at_1i").find("option[value='2021']").select_option
        find("#task_expired_at_2i").find("option[value='6']").select_option
        find("#task_expired_at_3i").find("option[value='3']").select_option
        find("#task_expired_at_4i").find("option[value='06']").select_option
        find("#task_expired_at_5i").find("option[value='03']").select_option
        find("#task_status_name").find("option[value='着手']").select_option
        find("#task_priority").find("option[value='高']").select_option
        check 'ルンピニー'
        page.accept_confirm do
          click_on '登録する'
        end
        visit new_task_path
        fill_in "タスク名", with: "task_name2"
        fill_in "内容", with: "task_content2"
        find("#task_expired_at_1i").find("option[value='2021']").select_option
        find("#task_expired_at_2i").find("option[value='6']").select_option
        find("#task_expired_at_3i").find("option[value='3']").select_option
        find("#task_expired_at_4i").find("option[value='10']").select_option
        find("#task_expired_at_5i").find("option[value='15']").select_option
        find("#task_status_name").find("option[value='完了']").select_option
        find("#task_priority").find("option[value='中']").select_option
        check 'トップキング'
        page.accept_confirm do
          click_on '登録する'
        end
        select "ルンピニー", from: "search_label"
        within '.search_box' do
          click_on '検索'
        end
        expect(page).to have_content 'task_name1'
        expect(page).to have_content 'ルンピニー'
      end
    end
  end
end
