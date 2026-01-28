select team,
	sum(wins_attributed) as team_wins
FROM player_stats as ps
join waa_calculations as waa
	on ps.name = waa.name
GROUP BY team
ORDER BY team;
