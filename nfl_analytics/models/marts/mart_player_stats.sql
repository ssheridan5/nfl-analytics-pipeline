SELECT
    qb.player_name,
    qb.season,
    qb.season_type,
    qb.team,
    
    td.team_name,
    td.team_nick,
    td.team_conf,
    td.team_division,

    qb.pass_completions,
    qb.pass_attempts,
    qb.pass_completion_percentage,
    qb.passing_yards,
    qb.passing_tds,
    qb.passing_interceptions,
    qb.td_int_ratio,
    qb.passing_air_yards,
    qb.passing_yards_after_catch,
    qb.passing_first_downs,
    qb.passing_epa,
    qb.passing_10,
    qb.passing_16,
    qb.passing_20,
    qb.passing_40,

    qb.carries,
    qb.rushing_yards,
    qb.yards_per_rushing_attempt,
    qb.rushing_tds,
    qb.rushing_fumbles,
    qb.rushing_fumbles_lost,
    qb.rushing_first_downs,
    qb.rushing_10,
    qb.rushing_12,
    qb.rushing_20,
    qb.rushing_40

FROM
    {{ ref('int_player_stats') }} as qb
LEFT JOIN 
    {{ source('nfl_raw', 'team_dimensions') }} as td
ON
    qb.team = td.team_abbr