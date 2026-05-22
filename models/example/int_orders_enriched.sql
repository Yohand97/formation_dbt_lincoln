--models/intermediate/int_orders_enriched.sql
{{config(materialized='table')}}

SELECT 
    o.order_id,
    o.customer_id,
    o.status,
    o.amount,
    o.order_date,

    --infos client
    C.customer_name,
    c.email,
    c.country,

    --infos produit (si table order_items existait)
    --Calculs derives
    CASE 
        WHEN o.amount >= 200 THEN 'high_value'
        WHEN o.amount >= 100 THEN 'medium_value'
        ELSE 'low_value'
    END AS order_segment,

    DATEDIFF('day',o.order_date,CURRENT_DATE) AS days_since_order

FROM {{ref('stg_customers')}} c ON o.customer_id = customer_id  

