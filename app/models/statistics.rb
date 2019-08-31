# frozen_string_literal: true

class Statistics < ApplicationRecord
  include Authority::Abilities
  include Concerns::HasAverageCompletionTime

  # Relationships
  belongs_to :user

  def readonly?
    true
  end
end
