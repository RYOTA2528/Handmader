Rails.application.routes.draw do

   devise_for :users, controllers: {
     registrations: 'public/users/registrations',
     sessions: 'public/users/sessions',
     passwords: 'public/users/passwords',
   }

   root to: 'homes#about'

  devise_for :admins, controllers: {
     sessions: 'admin/sessions',
     passwords: 'admin/passwords'
   }



namespace :admin do
  get  '/', to: 'homes#top'
  resources :genres, except: [:destory, :show]
  resources :users, only: [:show, :edit, :update]
end

namespace :public do
  get '/', to: 'homes#top'
  get '/unsubscribe', to: 'users#unsubscribe'
  patch '/withdraw', to: 'users#withdraw'
  resources :users, only: [:show, :edit, :update] do
# フォロー・フォローワー一覧作成。
   get :following, :followers, on: :member
# マイページにお気に入り一覧作成。その為、idが必要ないためcollectionにてルーティング作成
   get :favorites, on: :collection
  end
# どの投稿作品に対してのお気に入り・コメントかを判断するためid付与
  resources :post_items do
   resource :favorites, only: [:show, :create, :destroy]
   resources :comments, only: [:create, :destroy]
   get :ranking, on: :collection
  end
  resources :relationships, only: [:create, :destroy]
  resources :genres, only: [:show]
#  チャット機能導入
  resources :chats, only: [:create]
  resources :chat_rooms, only: [:create,:show]

end

end