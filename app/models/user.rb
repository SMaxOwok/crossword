class User < ApplicationRecord
  include Authority::UserAbilities

  devise :database_authenticatable, :registerable, :recoverable, :validatable

  # Relationships
  has_many :puzzles, dependent: :destroy
  has_many :daily_stats
  has_one :statistics
end
