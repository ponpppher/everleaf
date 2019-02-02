require 'rails_helper'


describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      # ユーザーAを作成
      # createではなくbuildでnewした時のオブジェクトを取得できる
      # user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.gmail')などで一部変更したユーザー作成ができる
      user_a = FactoryBot.create(:user)

      
      # 作成者がユーザーAであるタスクを作成しておく
      # userオブジェクトを指定しない場合、FactoryBotが勝手に作る
      FactoryBot.create(:task, name: 'first task', user: user_a)
    end

    context 'ユーザーAがログインしている時' do
      before do
        # ユーザーAでログイン
#        visit Rails.application.routes.url_helpers.login_path
        visit '/login'

        fill_in 'メールアドレス', with: 'test@gmail.com'
        fill_in 'パスワード', with: 'password'
        expect(page).to have_content 'ログイン'
      end

      it 'ユーザーAが作成したタスクが表示される' do
        # 作成済みのタスクの名称が画面上に表示されている事を確認
        expect(page).to have_content 'first task'
      end
    end
  end
end
