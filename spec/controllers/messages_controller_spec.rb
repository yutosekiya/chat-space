require 'rails_helper'

describe MessagesController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  #テストに必要なインスタンスを作成する

  describe '#index' do
    context 'log in' do
      before do
        login user
        get :index, params: { group_id: group.id } #インデックスメソッドを実行、group_idにgroup.idを渡すことを毎回行う
      end

      it 'assigns @message' do
        expect(assigns(:message)).to be_a_new(Message)
      end
      #assignsメソッドでは、getメソッドで呼び出された時にインスタンス変数に設定された値を参照できる
      #assigns(:message)はMessageクラスのインスタンスかつ未保存かどうかをチェックしている。
      it 'assigns @group' do
        expect(assigns(:group)).to eq group
      end
      #groupが作成されていることを、最初に作ったものとhash内にあるもの(ネスとして取得したデータが一致するか確認をしてる

      it 'redners index' do
        expect(response).to render_template :index
      end
      #responseは,example内でリクエストが行われた後の遷移先のビューの情報を持つインスタンス。render_template抹茶は、引数にアクション名をとり、引数で指定されたアクションがリクエストされた時に自動的に遷移するビューを返す→遷移先がindexであっているかを確認できる
    end

    context 'not log in' do
      before do
        get :index, params: { group_id: group.id }
      end

      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
      #ログインしていない時に帰ってくるresponseがユーザーのサインアップ画面であることを確認する
    end
  end

  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } } #attrubutes_forでhashを作成する→messages.rbで作成したインスタンスをハッシュにする　ただし、userとgroupについてはネストをしているので、引き継いでいる

    context 'log in' do
      before do
        login user
      end

      context 'can save' do
        subject {
          post :create,
          params: params
        }

        it 'count up message' do
          expect{ subject }.to change(Message, :count).by(1)
        end
        #正しく新しいデータが作成され、Messageモデルにデータが一つ増える

        it 'redirects to group_messages_path' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
        #正しくデータが保存され、元のグループのルーティングへ移動する
      end

      context 'can not save' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params
        }

        it 'does not count up' do
          expect{ subject }.not_to change(Message, :count)
        end

        it 'renders index' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context 'not log in' do

      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
