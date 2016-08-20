Rails.application.routes.draw do
  resources :temporary_users
  devise_for :users
  resources :answer_votes
  resources :answers
  resources :questions do
    resources :question_votes
  end
  resources :topics
  get 'join' => 'welcome#join'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
