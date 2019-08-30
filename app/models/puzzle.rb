# frozen_string_literal: true

class Puzzle < ApplicationRecord
  include ClassyEnum::ActiveRecord
  include Concerns::Filterable
  include Concerns::Sortable

  sortable_attributes :source, :date, :time_taken_in_seconds, :completed, :error_count,
                      :day_of_week, :revealed_count, default: :date

  # Relationships
  has_one :daily_stats,
          class_name: 'DailyStat',
          foreign_key: :day_of_week

  # Scopes
  scope :by_day_of_week, ->(day_of_week) { where(day_of_week: day_of_week) if day_of_week.present? }
  scope :by_completed, ->(completed = nil) { where(completed: completed) unless completed.nil? }
  scope :by_source, ->(source) { where(source: source) if source.present? }

  # Validations
  validates :hours, :minutes, :seconds,
            :day_of_week, :source, :date, presence: true
  validates :date, uniqueness: { scope: :source }
  validate :time_is_valid!, if: :completed?

  # Callbacks
  before_validation :set_day_of_week!
  before_save :set_time_taken_in_seconds!

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
    return '-' unless time_positive?

    retval = ''
    retval += "#{hours}h" if hours.positive?
    retval += "#{minutes}m" if minutes.positive?
    retval += "#{seconds}s" if seconds.positive?

    retval
  end

  def time_in_seconds
    (hours * 3600) + (minutes * 60) + seconds
  end

  private

  def time_positive?
    hours.positive? || minutes.positive? || seconds.positive?
  end

  def time_is_valid!
    return true if time_positive?

    errors.add(:time_taken, 'must be positive')
  end

  def set_day_of_week!
    assign_attributes(day_of_week: date.strftime('%A').downcase)
  end

  def set_time_taken_in_seconds!
    return unless %i[hours minutes seconds].any? { |key| changes[key].present? }

    assign_attributes(time_taken_in_seconds: time_in_seconds)
  end
end
