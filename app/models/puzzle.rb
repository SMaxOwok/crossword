# frozen_string_literal: true

class Puzzle < ApplicationRecord
  include ClassyEnum::ActiveRecord

  # Validations
  validates :hours, :minutes, :seconds,
            :day_of_week, :source, presence: true
  validates :date, uniqueness: true, presence: true
  validate :time_present?, if: :completed?

  # Callbacks
  before_validation :set_day_of_week!

  classy_enum_attr :source

  delegate :name, to: :source, prefix: true

  enum day_of_week: {
    monday: 'monday',
    tuesday: 'tuesday',
    wednesday: 'wednesday',
    thursday: 'thursday',
    friday: 'friday',
    saturday: 'saturday',
    sunday: 'sunday'
  }

  def formatted_time
    return '-' unless time_present?

    retval = ''
    retval += "#{hours}h" if hours.positive?
    retval += "#{minutes}m" if minutes.positive?
    retval += "#{seconds}s" if seconds.positive?

    retval
  end

  private

  def time_present?
    hours.positive? || minutes.positive? || seconds.positive?
  end

  def set_day_of_week!
    assign_attributes(day_of_week: date.strftime('%A').downcase)
  end
end
