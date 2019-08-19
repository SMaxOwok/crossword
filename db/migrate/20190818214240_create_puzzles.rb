class CreatePuzzles < ActiveRecord::Migration[5.2]
  def change
    create_table :puzzles, id: :uuid do |t|
      t.string :source, null: false
      t.date :date, null: false
      t.integer :hours, default: 0, null: false
      t.integer :minutes, default: 0, null: false
      t.integer :seconds, default: 0, null: false
      t.string :day_of_week, null: false
      t.integer :error_count, default: 0, null: false
      t.integer :revealed_count, default: 0, null: false
      t.boolean :completed, null: false

      t.timestamps
    end
  end
end
