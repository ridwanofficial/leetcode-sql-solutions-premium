with cte as(
    select
        *,
        sum(salary) over(
            partition by experience
            order by
                salary
        ) as sum_salary
    from
        candidates
),
cte1 as(
    select
        *
    from
        cte
    where
        sum_salary <= 70000
        and experience = 'Senior'
    order by
        sum_salary
),
cte2 as (
    select
        *
    from
        cte
    where
        sum_salary <= (
            select
                70000 - coalesce(max(sum_salary), 0)
            from
                cte1
        )
        and experience = 'Junior'
    order by
        sum_salary
)
select
    'Senior' as experience,
    count(employee_id) as accepted_candidates
from
    cte1
union
select
    'Junior' as experience,
    count(employee_id) as accepted_candidates
from
    cte2