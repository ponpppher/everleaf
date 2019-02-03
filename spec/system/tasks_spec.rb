require 'rails_helper'


describe 'タスク管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@gmail.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@gmail.com') }
  let!(:task_a) { FactoryBot.create(:task, name: 'first task', user: user_a) }

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  shared_examples_for 'ユーザーAが作成したタスクを表示' do
    it { expect(page).to have_content 'first task' }
  end


  describe '一覧表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }

      it_behaves_like 'ユーザーAが作成したタスクを表示'
    end

    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        # ユーザーAが作成したタスクの名称が画面上に表示されていない事を確認'
        expect(page).not_to have_content '最初のタスク'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }
      
      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクを表示'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }
    let(:task_name) { 'write new task test' }

    before do
      visit new_task_path
      fill_in '名称', with: task_name
      click_button '登録する'
    end

    context '新規作成画面で名称を入力した時' do
      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: 'write new task test'
      end
    end

    context '新規作成画面で名称を入力しなかった時' do
      let(:task_name) { '' }

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
  end
end
