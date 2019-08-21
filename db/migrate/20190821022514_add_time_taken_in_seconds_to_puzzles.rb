class AddTimeTakenInSecondsToPuzzles < ActiveRecord::Migration[5.2]
  def up
    add_column :puzzles, :time_taken_in_seconds, :integer, default: 0

    execute(
      <<~SQL.squish
        UPDATE puzzles
          SET time_taken_in_seconds = (COALESCE(hours * 3600, 0) + COALESCE(minutes * 60, 0) + COALESCE(seconds, 0))
      SQL
    )
  end

  def down
    remove_column :puzzles, :time_taken_in_seconds, default: 0
  end
end
