select * from race;

-- How many states were represented in the race?
select count(distinct state) as states from race;

-- What was the average time of men vs women?
select gender, round(avg(total_minutes), 0) as avg_time from race group by gender;

-- What were the youngest and oldest ages in the race?
select gender, min(age) as youngest, max(age) as oldest from race group by gender;

-- What was the avergae time for each age group?
with age_group as 
(
select 
total_minutes, 
case
	when age < 30 then '20-29'
    when age < 40 then '30-39'
    when age < 50 then '40-49'
    when age < 60 then '50-59'
    else '60+'
end as age_group
from race
)
select age_group, avg(total_minutes) as avg_time from age_group group by age_group order by age_group;

-- Who are the top 3 male and female runners?
with gender_rank as
(
select 
dense_rank() over(partition by gender order by total_minutes asc) as gender_rank, 
full_name, gender, total_minutes 
from race
)
select * from gender_rank where gender_rank < 4 order by gender desc;
