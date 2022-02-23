select * from 
{{ source('staging','stg_fhv_tripdata') }}
where extract(year from pickup_datetime) = 2019

-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}