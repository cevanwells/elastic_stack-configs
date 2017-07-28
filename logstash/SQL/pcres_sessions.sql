SELECT
    *
FROM
    session_log
WHERE
    id > :sql_last_value
ORDER BY
    id
