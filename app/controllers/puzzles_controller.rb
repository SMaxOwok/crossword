# frozen_string_literal: true

class PuzzlesController < ApplicationController
  before_action :set_puzzle!, only: [:edit, :destroy]

  def index
    @puzzles = Puzzle.with_order
  end

  def new
    @puzzle = Puzzle.new(date: Date.today)
  end

  def create
    @puzzle = Puzzle.new(puzzle_params)

    if @puzzle.save
      redirect_to puzzles_path
    else
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_puzzle!
    @puzzle = Puzzle.find(params[:id])
  end

  def puzzle_params
    params.require(:puzzle).permit(:source, :date, :hours, :minutes, :seconds,
                                   :completed, :error_count, :revealed_count)
  end
end
