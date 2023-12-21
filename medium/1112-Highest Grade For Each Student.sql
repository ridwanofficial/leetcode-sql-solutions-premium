with
    cte as (
        select
            *,
            row_number() over (
                partition by
                    student_id
                order by
                    grade desc,
                    course_id
            ) as rnk
        from
            enrollments
    )
select
    student_id,
    course_id,
    grade
from
    cte
where
    rnk = 1
order by
    student_id