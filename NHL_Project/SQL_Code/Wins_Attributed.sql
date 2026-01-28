select *
from player_stats;

with subsections as 
(select *,
	(sog*0.04/2.5)+(esg/2.5)+(esa*0.55/2.5) as evo,
    (ppg*0.85/2.5)+(ppa*0.45/2.5) as ppo,
    (hits*0.001/2.5)+(bs*0.15/2.5)+(plus_minus*0.03/2.5) as evd,
    (shg*0.95/2.5)+(sh_toi*0.005/2.5) as shd,
    (pim_drawn*0.8/2.5)-(pim*0.85/2.5) as pim_dif
from player_stats),

goals_wins as
(select *,
	(evo+ppo+evd+shd+pim_dif) as goals_attributed,
    (evo+ppo+evd+shd+pim_dif)/6 as wins_attributed
from subsections),

league_avg as 
(select *,
	avg(goals_attributed) over() as avg_goals_attributed,
	avg(wins_attributed) over() as avg_wins_attributed
from goals_wins)

select distinct name, age, pos, elc, salary, gp, evo, ppo, evd, shd, pim_dif, goals_attributed, wins_attributed,
	goals_attributed - avg_goals_attributed as gaa,
    wins_attributed - avg_wins_attributed as waa
from league_avg;