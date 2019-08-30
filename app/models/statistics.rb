# frozen_string_literal: true

class Statistics < ApplicationRecord
  include Concerns::HasAverageCompletionTime

  # Relationships
  belongs_to :user

  def readonly?
    true
  end
end
