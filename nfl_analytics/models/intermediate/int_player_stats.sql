SELECT
    player_name,
    team,
    season,
    season_type,
    pass_completions,
    pass_attempts,
    CAST(ROUND((pass_completions / NULLIF(pass_attempts,0))*100,2) as float64) as pass_completion_percentage,
    passing_yards,
    passing_tds,
    passing_interceptions,
    CAST(ROUND((passing_tds / NULLIF(passing_interceptions,0)),2) as float64) as td_int_ratio,
    passing_air_yards,
    passing_yards_after_catch,
    passing_first_downs,
    passing_epa,
    -- Unsure why the staging to intermediate data is changing this from integer data type to float during dbt build.
    --wrapping passing_10 in CAST statement to ensure it remains an integer
    CAST(passing_10 as integer) as passing_10,
    passing_16,
    passing_20,
    passing_40,
    carries,
    rushing_yards,
    CAST(ROUND((rushing_yards / NULLIF(carries,0)),2) as float64) as yards_per_rushing_attempt,
    rushing_tds,
    rushing_fumbles,
    rushing_fumbles_lost,
    rushing_first_downs,
    rushing_10,
    rushing_12,
    rushing_20,
    rushing_40
FROM 
    {{ ref('stg_player_stats') }}
WHERE
    position = 'QB'
AND
    player_name is not null