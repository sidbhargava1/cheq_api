require 'api_constraints'

CheqApi::Application.routes.draw do
  mount SabisuRails::Engine => "/sabisu_rails"
  devise_for :users
  # Api definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
      resources :users, :only => [:index, :show, :create, :update, :destroy] do
        resources :restaurants, :only => [:create, :update, :destroy]
      end
      
      resources :sessions, :only => [:create, :destroy]
      resources :restaurants, :only => [:show, :index]
      resources :menus, :only => [:show, :index]
    end
  end
end