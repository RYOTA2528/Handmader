Rails.application.routes.draw do

  devise_for :admins, skip: :all
  devise_scope :admin do
  get '/admin/sign_in' => 'admin/sessions#new', as: :new_admin_session
  post '/admin/sign_in' => 'admin/sessions#create', as: :admin_session
  delete 'admin/sign_out' => 'admin/sessions#destroy', as: :destroy_admin_session
  get '/admin/password/new' => 'admin/passwords#new', as: :new_admin_password
  get '/admin/password/edit' => 'admin/password#edit', as: :edit_admin_password
  patch '/admin/password' => 'admin/passwords#update', as: :update_admin_password
  post '/admin/password/new' => 'admin/passwors#create', as: :create_admin_password
end

namespace :admin do
  root to: 'homes#top'
  resources :genres, except: [:destory]
end

end