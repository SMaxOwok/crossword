# frozen_string_literal: true

Rails.application.routes.draw do
  root 'puzzles#index'

  resources :puzzles, except: [:show]
  resources :statistics, only: [:index]
end
