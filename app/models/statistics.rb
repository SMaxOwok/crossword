# frozen_string_literal: true

class Statistics < ApplicationRecord
  include HasAverageCompletionTime

  def readonly?
    true
  end

  class << self
    def instance
      first
    end
  end
end
