SELECT
    ROUND(100.0 * (COUNT(*) FILTER (WHERE completed)::DECIMAL / COUNT(*)::DECIMAL), 2)::DECIMAL AS percent_completed,
    AVG(time_taken_in_seconds) FILTER (WHERE completed)::INTEGER AS average_completion_time_in_seconds,
    COALESCE(((COUNT(*) FILTER (WHERE completed)))) AS completed_count,
    COALESCE(SUM(error_count), 0) AS error_count,
    COALESCE(SUM(revealed_count), 0) AS revealed_count
FROM
    puzzles
