Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#top'
  get '/home', to: 'homes#top', as: :home

  resources :spots, only: %i[new create show index]

  resources :spot_registrations, only: [] do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      get 'step4'
      get 'confirmation'
    end
  end

  resources :searches, only: %i[new] do
    collection do
      post 'search_spot'
    end
  end

  namespace :api do
    namespace :v1 do
      post 'spots/check', to: 'spots#check'
    end
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
