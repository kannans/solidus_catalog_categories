Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :categories do
      collection do
        post :update_positions
      end
      resources :catalogs
    end

    resources :catalogs, only: [:index, :show] do
      collection do
        get :search
      end
    end
  end

  namespace :api, defaults: { format: 'json' } do
    resources :categories do
      member do
        get :jstree
      end
      resources :catalogs do
        member do
          get :jstree
        end
      end
    end

    resources :catalogs, only: [:index]
  end
end
