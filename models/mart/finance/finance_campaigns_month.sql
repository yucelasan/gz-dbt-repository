SELECT
    DATE_TRUNC(date_date, MONTH) AS datemonth,
    
    -- Hesaplanan KPI'lar (ROUND(..., 2) uygulandı)
    ROUND(SUM(operational_margin - ads_cost), 2) AS ads_margin,
    -- average_basket zaten yuvarlanmıştı, formül bozulmadan tutuldu.
    ROUND(SUM(revenue) / NULLIF(SUM(nb_of_orders),0), 2) AS average_basket,
    
    -- Agregasyon Kolonları (HEPSİNE ROUND(..., 2) uygulandı)
    ROUND(SUM(operational_margin), 2) AS operational_margin,
    ROUND(SUM(ads_cost), 2) AS ads_cost,
    
    -- Sayım metriklerine (Impression, Click, Quantity) de yuvarlama uygulandı (Talebinize göre)
    ROUND(SUM(ads_impressions), 2) AS ads_impression,
    ROUND(SUM(ads_clicks), 2) AS ads_clicks,
    ROUND(SUM(quantity), 2) AS quantity,
    
    -- Finansal Metrikler (ROUND(..., 2) uygulandı)
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(purchase_cost), 2) AS purchase_cost,
    ROUND(SUM(margin), 2) AS margin,
    ROUND(SUM(shipping_fee), 2) AS shipping_fee,
    ROUND(SUM(log_cost), 2) AS log_cost,
    ROUND(SUM(ship_cost), 2) AS ship_cost
    
FROM {{ ref('int_campaigns_day') }}
FULL OUTER JOIN {{ ref('finance_days') }}
USING (date_date)

GROUP BY datemonth
ORDER BY datemonth DESC