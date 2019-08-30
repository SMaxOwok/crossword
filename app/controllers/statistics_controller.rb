# frozen_string_literal: true

class StatisticsController < ApplicationController
  def index
    @statistics = current_user.statistics
  end
end
