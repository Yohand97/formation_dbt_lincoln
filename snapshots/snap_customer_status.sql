{% snapshot customer_snapshots %}

{{
    config(

            target_schema = 'snapshots',
            unique_key = 'email',
            strategy = 'check',
            check_cols = ['email', 'country', 'status']  
    )


}}

select * from {{ ref('raw_customers')}}


{% endsnapshot %}