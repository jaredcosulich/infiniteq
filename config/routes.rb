Rails.application.routes.draw do
  resources :answer_votes
  resources :answers
  resources :questions do
    resources :question_votes
  end
  resources :topics
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
