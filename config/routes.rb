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
  resources :users, only: [:new, :create, :show, :edit, :update]
  #   devise_for :users, controllers: {
  #   registrations: 'users/registrations',
  #   sessions: 'users/sessions'
  # }
  get 'users/unsubscribe', to: 'users#unsubscribe'
  patch 'users/withdraw', to: 'users#withdraw'
end

end