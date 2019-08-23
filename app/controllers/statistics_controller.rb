# frozen_string_literal: true

class StatisticsController < ApplicationController
  def index
    @statistics = Statistics.instance
  end
end
