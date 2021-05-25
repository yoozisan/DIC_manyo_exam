require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'task', content: 'task', expired_at: '2021-06-03 06:03:00', status_name: '未着手') }
  let!(:task2) { FactoryBot.create(:task, title: 'task2', content: 'task2', expired_at: '2021-07-07 07:07:00', status_name: '着手') }
  let!(:task3) { FactoryBot.create(:task, title: 'task3', content: 'task3', expired_at: '2021-06-16 06:03:00', status_name: '完了') }
  before do
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "タスク名", with: "task_name"
        fill_in "内容", with: "task_content"
        find("#task_expired_at_1i").find("option[value='2021']").select_option
        find("#task_expired_at_2i").find("option[value='5']").select_option
        find("#task_expired_at_3i").find("option[value='3']").select_option
        find("#task_expired_at_4i").find("option[value='10']").select_option
        find("#task_expired_at_5i").find("option[value='15']").select_option
        find("#task_status_name").find("option[value='着手']").select_option
        click_on '登録する'
        expect(page).to have_content 'task_name'
        expect(page).to have_content '着手'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list =all('ul li')
        expect(task_list[0]).to have_content 'task3'
      end
    end
    context 'タスクが終了期限の降順で並んでいる場合' do
      it '終了期限が遅いタスクが一番上に表示される' do
      # binding.irb
        within '.sort_expired' do
          click_on '終了期限でソートする'
        end
        task_list = all('ul li')
        expect(task_list[0]).to have_content 'task2'
      end
    end
  end

  describe '検索機能' do
    context 'タイトルで検索した場合' do
      it '該当タイトルのタスクが表示される' do
        fill_in "search_title", with: "3"
        click_on '検索'
        expect(page).to have_content 'task3'
      end
    end
    context 'ステータスで検索した場合' do
      it '該当ステータスのタスクが表示される' do
        find("#search_status").find("option[value='完了']").select_option
        # binding.irb
        click_on '検索'
        expect(page).to have_content 'task3'
      end
    end
    context 'タイトルとステータスの両方で検索した場合' do
      it '該当のタスクが表示される' do
        fill_in "search_title", with: "2"
        find("#search_status").find("option[value='着手']").select_option
        click_on '検索'
        expect(page).to have_content 'task2'
        expect(page).to have_content '着手'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         visit task_path(task.id)
         expect(page).to have_content 'task'
       end
     end
  end
end
