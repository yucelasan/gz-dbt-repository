select
f.date_date as date,
round((f.operational_margin - c.ads_cost),2) as ads_margin,
f.avg_basket,
f.operational_margin,
c.ads_cost,
c.ads_impressions,
c.ads_clicks,
f.quantity,
f.revenue,
f.purchase_cost,
f.margin,
f.shipping_fee,
f.log_cost,
f.ship_cost,
from
{{ref ('finance_days')}} as f
full outer join {{ref ('int_campaigns_day')}} as c
on f.date_date = c.date_date
