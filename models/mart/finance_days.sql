with
    orders_per_day as (
        select
            date_date,
            count(distinct orders_id) as nb_of_orders,
            round(sum(revenue), 2) as revenue,
            round(sum(margin), 2) as margin,
            round(sum(operational_margin), 2) as operational_margin,
            round(sum(purchase_cost), 2) as purchase_cost,
            round(sum(ship_cost), 2) as ship_cost,
            round(sum(shipping_fee), 2) as shipping_fee,
            round(sum(log_cost), 2) as log_cost,
            sum(quantity) as quantity
        from {{ ref("int_orders_operational") }}
        group by date_date
        order by nb_of_orders desc
    )
select orders.*, round(orders.revenue / nullif(orders.nb_of_orders, 0), 2) as avg_basket
from orders_per_day as orders
order by date_date desc
