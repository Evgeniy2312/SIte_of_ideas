Rails.application.routes.draw do
  get '/current_user', to: 'users/current#index'

  # admin
  resources :admin, only: %i[destroy show index]
  get '/find_by_role/:role', to: 'admin#find_by_role'
  #

  # idea
  resources :idea
  get '/show_all_ideas', to: 'idea#show_all_ideas'
  put '/update_status/:id/:access', to: 'idea#update_status'
  put '/add_investor_idea/:id', to: 'idea#add_investor_to_idea'
  get '/get_by_sphere/:sphere', to: 'idea#get_by_sphere'
  get '/get_by_tag/:tag_name', to: 'idea#get_by_tag'
  get '/get_by_author/:name_author', to: 'idea#get_by_author'
  get '/get_by_rate/:rate_idea', to: 'idea#get_by_rate'
  get '/get_by_amount_like/:amount', to: 'idea#get_by_amount_like'
  get '/get_by_problem/:problem', to: 'idea#get_by_problem'
  get '/get_by_location/:location', to: 'idea#get_by_location'
  get '/get_by_name/:name', to: 'idea#get_by_name'
  #

  # comment
  resources :comment, only: %i[update destroy show]
  post '/create_comment/:id', to: 'comment#create'
  post '/create_under_comment/:comment_id', to: 'comment#create_under_comment'
  put '/update_comment/:comment_id', to: 'comment#update'
  get '/show_comment_idea/:id', to: 'comment#show_comment_to_idea'
  get '/show_under_comment/:comment_id', to: 'comment#show_under_comment'
  #

  # tag
  resources :tag, only: %i[update destroy show]
  post '/create_tags/:id', to: 'tag#create'
  put '/update_tag/:tag_id', to: 'tag#update'
  delete '/delete_tag/:tag_id', to: 'tag#destroy'
  get '/get_tag/:tag_id', to: 'tag#show'
  get '/get_tags/:q', to: 'tag#get_tags'
  get '/get_tags_idea/:id', to: 'tag#index'
  #

  # dislike
  post '/add_dislike/:id', to: 'dislike#create'
  delete '/delete_dislike/:id', to: 'dislike#destroy'
  get '/get_dislike_idea/:id', to: 'dislike#get_amount_dislikes'

  # like
  post '/add_like/:id', to: 'like#create'
  delete '/delete_like/:id', to: 'like#destroy'
  get '/get_like_idea/:id', to: 'like#get_amount_likes'
  #

  # rate
  post '/add_rate/:id', to: 'rate#create'
  delete '/delete_rate/:id', to: 'rate#destroy'
  put '/update_rate/:id', to: 'rate#update'
  get '/get_rate_idea/:id', to: 'rate#get_rate_idea'
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
    passwords: 'users/password',
    confirmations: 'users/confirmations'
  }






end
