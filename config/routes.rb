Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: redirect('/admin')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post 'mail-processor' => 'mail_webhook#create'
  get 'mail-processor' => 'mail_webhook#create'
end
