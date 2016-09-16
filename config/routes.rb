Rails.application.routes.draw do
  resources :followings
  resources :flags
  namespace :admin do
    root :to => "admin#index"
  end

  resources :topics
  resources :questions do
    resources :question_votes
  end
  resources :answers do
    resources :answer_votes
  end
  resources :comments

  resources :temporary_users
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  resources :users, only: [:show]

  get 'join' => 'welcome#join'

  root 'welcome#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
