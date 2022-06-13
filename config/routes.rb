Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'

  namespace :api do
    resources :sessions
    resources :users do
      collection do
        get 'me'
      end
    end
  end

  get '*path', to: 'static_pages#top'
end
