class UpdateDailyStatsToVersion4 < ActiveRecord::Migration[5.2]
  def change
    update_view :daily_stats, version: 4, revert_to_version: 3
  end
end
