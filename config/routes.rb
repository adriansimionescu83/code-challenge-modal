Rails.application.routes.draw do
  root 'cycles#index'
  get '/:cycle_id/invitations/new', to: 'invitations#new', as: :new_invitation
  post '/:cycle_id/invitations', to: 'invitations#create', as: :create_invitation
  get '/:cycle_id/invitations/:invitation_id/show', to: 'invitations#show', as: :show_invitation
end
