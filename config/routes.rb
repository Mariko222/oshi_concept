Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'

  namespace :api, format: 'json' do
    resources :genres
    resources :characters
    resources :mygenres
    resources :mygenre_characters
    resources :mypage
    resources :posts
    resources :sessions
    resources :users do
      collection do
        get 'me'
      end
    end

    post "oauth/callback", to: "oauths#callback"
    get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider

    resources :password_resets, only: %i[create edit update], params: :token
  end

  namespace :admin do
    resources :sessions, only: %i[create]
    get 'login', to: 'sessions#new'
    delete 'logout', to: 'sessions#destroy'
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get '*path', to: 'static_pages#top', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
