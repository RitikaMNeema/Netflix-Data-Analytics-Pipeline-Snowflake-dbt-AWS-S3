with raw_movies as(
    select * from MOVIELENS.RAW.RAW_MOVIES
)
SELECT movieID as movie_id,
title,
genres
from raw_movies