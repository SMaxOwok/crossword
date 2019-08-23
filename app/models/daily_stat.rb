# frozen_string_literal: true

class DailyStat < ApplicationRecord
  self.primary_key = 'day_of_week'

  # Relationships
  has_one :fastest_puzzle,
          class_name: 'Puzzle',
          foreign_key: :id,
          primary_key: :fastest_puzzle_id

  def readonly?
    true
  end

  def formatted_average_time
    return '-' unless average_completion_time_in_seconds.present?

    retval = ''
    retval += "#{average_hours}h" if average_hours.positive?
    retval += "#{average_minutes}m" if average_minutes.positive?
    retval += "#{average_seconds}s" if average_seconds.positive?

    retval
  end

  def formatted_fastest_time
    return '-' unless fastest_puzzle.present?

    fastest_puzzle.formatted_time
  end

  private

  def average_hours
    average_completion_time_in_seconds.to_i / 3600
  end

  def average_minutes
    (average_completion_time_in_seconds.to_i % 3600) / 60
  end

  def average_seconds
    (average_completion_time_in_seconds.to_i % 3600) % 60
  end
end
