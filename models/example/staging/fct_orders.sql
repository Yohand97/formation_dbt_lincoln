{{ config(materialized = 'table')}}

select 
    order_id,
    customer_id,
    order_date,
    status,
    amount,
    order_segment,
    days_since_order,

    --Metriques calculees
    CASE 
        WHEN status = 'completed' THEN amount
        ELSE 0
    END AS revenue,

    1 AS order_count

FROM {{ref('int_orders_enriched')}}
WHERE order_date >= '2024-01-01'   
