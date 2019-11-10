Rails.application.routes.draw do
  resources :workers
  resources :users
  resources :blogs, only: %i[index show new create]
  patch 'blogs/update', defaults: { format: 'json' }, to: 'blogs#update_list'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
