# frozen_string_literal: true

class PuzzlesController < ApplicationController
  before_action :set_puzzle!, only: %i[edit update destroy]

  def index
    @puzzles = Puzzle.with_order
    @daily_stats = DailyStat.includes(:fastest_puzzle).find_by(day_of_week: current_day)
  end

  def new
    @puzzle = Puzzle.new(date: Date.today)
  end

  def create
    @puzzle = Puzzle.new(puzzle_params)

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
    @puzzle = Puzzle.find(params[:id])
  end

  def puzzle_params
    params.require(:puzzle).permit(:source, :date, :hours, :minutes, :seconds,
                                   :completed, :error_count, :revealed_count)
  end
end
