Rails.application.routes.draw do
  get '/current_user', to: 'users/current#index'

  # admin
  resources :admin, only: %i[destroy show index]
  get '/find_by_role/', to: 'admin#find_by_role'
  #:
  as :user do
    put "/update_password" => "users/registrations#update_password"
  end

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/password'
  }





end
