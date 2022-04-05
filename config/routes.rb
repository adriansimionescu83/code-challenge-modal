Rails.application.routes.draw do
  root 'cycles#index'
  resources :cycles, only: :show do
    resources :invitations, only: :create
  end
end
