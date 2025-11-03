



SELECT
-- md5(cast(coalesce(cast(user_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(movie_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(tag as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS row_key,
    user_id,
    movie_id,
    tag,
    CAST(tag_timestamp AS TIMESTAMP_NTZ) AS tag_timestamp
FROM MOVIELENS.DEV.src_tags
LIMIT 100 

