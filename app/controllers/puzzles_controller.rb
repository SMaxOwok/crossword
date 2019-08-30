# frozen_string_literal: true

class PuzzlesController < ApplicationController
  before_action :set_puzzle!, only: %i[edit update destroy]

  def index
    @puzzles = current_user.puzzles.filter(puzzle_filter_params).sorted(params).page(params[:page])
    @daily_stats = current_user.daily_stats.includes(:fastest_puzzle).find_by(day_of_week: current_day)
  end

  def new
    @puzzle = current_user.puzzles.new(date: Date.today)
  end

  def create
    @puzzle = current_user.puzzles.new(puzzle_params)

    if @puzzle.save
      redirect_to puzzles_path,
                  flash: { success: 'Record successfully created' }
    else
      render :new
    end
  end

  def edit; end

  def update
    if @puzzle.update(puzzle_params)
      redirect_to puzzles_path,
                  flash: { success: 'Record successfully updated' }
    else
      render :edit
    end
  end

  def destroy
    @puzzle.destroy

    redirect_to puzzles_path,
                flash: { success: 'Record successfully destroyed' }
  end

  private

  def set_puzzle!
    @puzzle = current_user.puzzles.find(params[:id])
  end

  def puzzle_params
    params.require(:puzzle).permit(:source, :date, :hours, :minutes, :seconds,
                                   :completed, :error_count, :revealed_count)
  end

  def puzzle_filter_params
    params.permit(filter: [:completed, :source, :day_of_week])[:filter]
  end
end
