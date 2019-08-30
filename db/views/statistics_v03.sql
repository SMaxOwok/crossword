SELECT
    ROUND(100.0 * (COUNT(*) FILTER (WHERE completed)::DECIMAL / COUNT(*)::DECIMAL), 2)::DECIMAL AS percent_completed,
    AVG(time_taken_in_seconds) FILTER (WHERE completed)::INTEGER AS average_completion_time_in_seconds,
    COALESCE(((COUNT(*) FILTER (WHERE completed)))) AS completed_count,
    COALESCE(SUM(error_count), 0) AS error_count,
    COALESCE(SUM(revealed_count), 0) AS revealed_count,
    ROUND(AVG(error_count)::NUMERIC, 2) AS average_error_count,
    ROUND(AVG(revealed_count)::NUMERIC, 2) AS average_revealed_count,
    user_id
FROM
    puzzles
INNER JOIN
    users
ON
    puzzles.user_id = users.id
GROUP BY
    user_id

