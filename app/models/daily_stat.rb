# frozen_string_literal: true

class DailyStat < ApplicationRecord
  include Concerns::HasAverageCompletionTime

  self.primary_key = 'day_of_week'

  # Relationships
  has_one :fastest_puzzle,
          class_name: 'Puzzle',
          foreign_key: :id,
          primary_key: :fastest_puzzle_id

  def readonly?
    true
  end

  def formatted_fastest_time
    return '-' unless fastest_puzzle.present?

    fastest_puzzle.formatted_time
  end
end
