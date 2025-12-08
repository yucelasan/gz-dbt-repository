-- models/intermediate/int_combined_campaign_data.sql

-- Bu model, 4 farklı staging tablosundaki kampanya verilerini birleştirir.


select * from {{ ref('stg_raw__adwords') }}
union all
select * from {{ ref('stg_raw__bing') }}
union all
select * from {{ ref('stg_raw__criteo') }}
union all
select * from {{ ref('stg_raw__facebook') }}