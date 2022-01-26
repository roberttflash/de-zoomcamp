-- Q3
select count(*) from yellow_taxi_trips
where cast(tpep_pickup_datetime as date) = '20210115';

-- q4
select * from yellow_taxi_trips where tip_amount = 
(select max(tip_amount) from yellow_taxi_trips
where cast(tpep_pickup_datetime as date) between '20210101' and '20210131');

-- Q5
select zz."Zone", z."Zone", count(*) as total_count from yellow_taxi_trips ytt
left join zones z
on ytt."PULocationID" = z."LocationID"
left join zones zz
on ytt."DOLocationID" = zz."LocationID"
where z."Zone" = 'Central Park'
and cast(ytt.tpep_pickup_datetime as date) = '20210114'
group by zz."Zone", z."Zone"
order by zz."Zone" desc;	-- 1087

select * from zones;

-- Q6
select concat(z."Zone", '/', zz."Zone") as pu_do, 
avg(ytt.total_amount) as avg_total_amount from yellow_taxi_trips ytt
--ytt.total_amount from yellow_taxi_trips ytt
left join zones z
on ytt."PULocationID" = z."LocationID"
left join zones zz
on ytt."DOLocationID" = zz."LocationID"
group by concat(z."Zone", '/', zz."Zone")
order by avg_total_amount desc;
--order by ytt.total_amount desc;



