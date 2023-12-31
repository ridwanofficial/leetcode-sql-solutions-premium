with
    cte as (
        select
            sum(price) as sell,
            seller_id
        from
            Sales_1082
        group by
            seller_id
    )
select
    seller_id
from
    cte
where
    sell in (
        select
            max(sell)
        from
            cte
    )