# frozen_string_literal: true

namespace :development do
  desc 'Loads data for development environment'
  task load: :environment do
    Development::DataLoader.run!
  end
end
