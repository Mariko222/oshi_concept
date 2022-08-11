Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'

  namespace :api, format: 'json' do
    resources :genres
    resources :characters
    resources :mygenres
    resources :mygenre_characters
    resources :sessions
    resources :users do
      collection do
        get 'me'
      end
    end
    resources :mypage
    resources :posts

    post "oauth/callback", to: "oauths#callback"
    get "oauth/callback", to: "oauths#callback"
    get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
  end

  get '*path', to: 'static_pages#top', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
