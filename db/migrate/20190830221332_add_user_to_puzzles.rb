class AddUserToPuzzles < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to :puzzles, :user, type: :uuid, null: false
  end
end
