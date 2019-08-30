SELECT
    day_of_week,
    user_id,
    ROUND(100.0 * (COUNT(*) FILTER (WHERE completed)::DECIMAL / COUNT(*)::DECIMAL), 2) AS percent_completed,
    (array_agg(id ORDER BY time_taken_in_seconds ASC NULLS LAST))[1] AS fastest_puzzle_id,
    COALESCE(SUM(hours), 0) AS hours,
    COALESCE(SUM(minutes), 0) AS minutes,
    COALESCE(SUM(seconds), 0) AS seconds,
    AVG(time_taken_in_seconds) FILTER (WHERE completed)::INTEGER AS average_completion_time_in_seconds,
    COALESCE(SUM(error_count), 0) AS error_count,
    COALESCE(SUM(revealed_count), 0) AS revealed_count,
    ROUND(AVG(error_count)::NUMERIC, 2) AS average_error_count,
    ROUND(AVG(revealed_count)::NUMERIC, 2) AS average_revealed_count,
    COALESCE(((COUNT(*) FILTER (WHERE completed)))) AS completed_count
FROM
    puzzles
GROUP BY
    user_id, day_of_week
