# frozen_string_literal: true

module Development
  class DataLoader < ActiveInteraction::Base

    def execute
      truncate_db
      load_users
      load_puzzles

      output_summary
    end

    private

    def truncate_db
      clear = %w[User Puzzle]
      clear.each do |model_name|
        logger.info "Truncating #{model_name} table..."
        model_name.constantize.destroy_all
      end
    end

    def load_users(count = 10)
      count.times do |i|
        user = User.create(
          email: "crossword-#{i + 1}@example.com",
          password: 'password'
        )

        logger.info("User created with email #{user.email}.")
      end
    end

    def load_puzzles(count = 50)
      count.times do |i|
        puzzle = Puzzle.create(
          date: start_date - i.days,
          hours: rand(0..1),
          minutes: rand(0..59),
          seconds: rand(0..59),
          source: Source.all.sample,
          error_count: rand(0..20),
          revealed_count: rand(0..20),
          completed: rand(0..1)
        )

        logger.info("Puzzle created for #{puzzle.date.strftime('%m-%d-%Y')}.")
      end
    end

    def output_summary
      logger.info "#{User.count} users, and #{Puzzle.count} puzzles loaded."
    end

    def start_date
      @start_date ||= Date.today - 1.week
    end

    def logger
      @logger ||= Logger.new STDOUT
    end
  end
end
