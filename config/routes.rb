Rails.application.routes.draw do
  get 'home/index'

  # Diagnosis Code Lookups
  get  'codes/index', controller: :codes, action: :index, as: :codes
  get  'codes/description', controller: :codes, action: :description
  post 'codes/submit_code', controller: :codes, action: :submit_code

  root to: 'home#index'
end
