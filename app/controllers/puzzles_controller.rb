# frozen_string_literal: true

class PuzzlesController < ApplicationController
  before_action :set_puzzle!, only: [:edit, :destroy]

  def index
    @puzzles = Puzzle.all
  end

  def new
    @puzzle = Puzzle.new
  end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_puzzle!
    @puzzle = Puzzle.find(params[:id])
  end
end
