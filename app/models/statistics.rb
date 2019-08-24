# frozen_string_literal: true

class Statistics < ApplicationRecord
  include Concerns::HasAverageCompletionTime

  def readonly?
    true
  end

  class << self
    def instance
      first
    end
  end
end
