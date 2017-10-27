Rails.application.routes.draw do
  get 'rating/set'

  post 'posts/create'
  get 'posts/top/:id', to: 'posts#top'
  get 'posts/repeatedly_ip_users'
  get 'users/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
