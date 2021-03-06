# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'puzzles#index'

  resources :puzzles, except: [:show]
  resource :statistics, only: [:show]
end
