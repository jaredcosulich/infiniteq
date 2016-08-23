Rails.application.routes.draw do
  resources :topics
  resources :questions do
    resources :question_votes
  end
  resources :answers
  resources :answer_votes

  resources :temporary_users
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  get 'join' => 'welcome#join'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
