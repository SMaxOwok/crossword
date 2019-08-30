class UpdateDailyStatsToVersion5 < ActiveRecord::Migration[5.2]
  def change
    update_view :daily_stats, version: 5, revert_to_version: 4
  end
end
