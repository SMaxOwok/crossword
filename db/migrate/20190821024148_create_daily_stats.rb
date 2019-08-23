class CreateDailyStats < ActiveRecord::Migration[5.2]
  def change
    create_view :daily_stats
  end
end
