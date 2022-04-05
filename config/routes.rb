Rails.application.routes.draw do
  root 'cycles#index' do
    resources :invitations, only: :create
  end
end
