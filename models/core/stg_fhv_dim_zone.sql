select ft.dispatching_base_num, ft.pickup_datetime,
ft.dropoff_datetime, pu.zone as pickup_zone, dof.locationid as dropoff_zone, ft.SR_Flag from `de-zoomcamp-hw.dbt_dataset_asia.external_fhv_tripdata` ft
left join `de-zoomcamp-hw.dbt_tgunawan.dim_zones` pu
on 1=1
and ft.PULocationID = pu.locationid
left join `de-zoomcamp-hw.dbt_tgunawan.dim_zones` dof
on 1=1
and ft.DOLocationID = dof.locationid
where pu.service_zone != 'N/A' --in ('Green Zone', 'Yellow Zone')
and dof.service_zone != 'N/A' --in ('Green Zone', 'Yellow Zone')