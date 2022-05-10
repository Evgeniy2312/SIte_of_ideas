Rails.application.routes.draw do
  get '/current_user', to: 'users/current#index'

  # admin
  resources :admin, only: %i[destroy show index]
  get '/find_by_role/', to: 'admin#find_by_role'
  #

  # idea
  resources :idea
  get '/show_all_ideas', to: 'idea#show_all_ideas'
  put '/update_status/:id/:access', to: 'idea#update_status'
  put '/add_investor_idea/:id', to: 'idea#add_investor_to_idea'
  #

  # comment
  resources :comment, only: %i[update destroy show]
  post '/create_comment/:idea_id', to: 'comment#create'
  post '/create_under_comment/:id', to: 'comment#create_under_comment'
  get '/show_comment_idea/:idea_id', to: 'comment#show_comment_to_idea'
  get '/show_under_comment/:id', to: 'comment#show_under_comment'
  #

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
