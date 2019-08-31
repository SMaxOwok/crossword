# frozen_string_literal: true

class StatisticsController < ApplicationController
  before_action :set_statistics!, only: [:show]

  def show
    authorize_action_for(@statistics)
  end

  private

  def set_statistics!
    @statistics = current_user.statistics
  end
end
