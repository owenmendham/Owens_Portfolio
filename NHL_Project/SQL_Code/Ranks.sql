select *,
	salary_rank + wins_rank as total_rank

from (select *,
dense_rank() over(order by salary) as salary_rank,
dense_rank() over(order by wins_attributed desc) as wins_rank
from waa_calculations) ranks
where elc="N";
