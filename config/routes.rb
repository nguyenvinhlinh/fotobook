Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               omniauth_callbacks: "users/omniauth_callbacks"
             }
  root "pictures#index"
  resources :pictures,  only: [:show, :index, :new] do
    collection do
      get 'upload', to: 'pictures#upload'
    end
  end
  
  resources :tags, param: :tag_name do
    collection do
      get 'ac_tag', to: 'tags#ac_by_tag' 
    end
  end

  resource :users do
    resources :pictures, except: [:index] do
      collection do
        get '', to: 'pictures#myIndex'
      end
    end
  end
end
