# frozen_string_literal: true

module HasAverageCompletionTime
  extend ActiveSupport::Concern

  def formatted_average_time
    return '-' unless average_completion_time_in_seconds.present?

    retval = ''
    retval += "#{average_hours}h" if average_hours.positive?
    retval += "#{average_minutes}m" if average_minutes.positive?
    retval += "#{average_seconds}s" if average_seconds.positive?

    retval
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
