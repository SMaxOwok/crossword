class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  # Relationships
  has_many :puzzles, dependent: :destroy
end
