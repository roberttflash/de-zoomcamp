-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `de-zoomcamp-hw.fhv.external_fhv_tripdata`
OPTIONS (
    format = 'PARQUET',
    uris = ['gs://dtc_data_lake_dtc-de-339302/raw/fhv_tripdata_2019-*.parquet']
);

-- answer for no 1
SELECT count(*) FROM `de-zoomcamp-hw.fhv.external_fhv_tripdata`;    -- 42084899

-- answer for no 2
SELECT count(distinct dispatching_base_num) FROM `de-zoomcamp-hw.fhv.external_fhv_tripdata`;    -- 792


-- answer for no 3
-- it only uses one filter, which is dropoff_datetime with the datatype datetime, and because dispatching_base_num only used for the order, 
-- we can use simply using the partition by dropoff_datetime to improve query performance and reduce cost.

-- answer for no 4
-- Create a partitioned table from external table
CREATE OR REPLACE TABLE `de-zoomcamp-hw.fhv.external_fhv_tripdata_partitioned_clustered`
PARTITION BY 
    DATE(dropoff_datetime) 
CLUSTER BY dispatching_base_num AS
SELECT * FROM `de-zoomcamp-hw.fhv.external_fhv_tripdata`;

SELECT COUNT(*) AS TOTAL_COUNT FROM `de-zoomcamp-hw.fhv.external_fhv_tripdata_partitioned_clustered`
WHERE DATE(dropoff_datetime) BETWEEN '2019-01-01' AND '2019-03-31'
AND dispatching_base_num IN ('B00987', 'B02060', 'B02279'); -- 26643 -- This query will process 400.1 MiB when run.
-- Query complete (0.3 sec elapsed, 135.1 MB processed)

-- answer for no 5
-- because partitioning only can be used by column with time-unit column, only dispatching_base_num that could be partitioned,
-- but SR_Flag is clustered
SELECT DISTINCT 'SR_Flag' FROM `de-zoomcamp-hw.fhv.external_fhv_tripdata`;

-- answer for no 6
-- If the data size is less than 1 GB, it will not have much improvement by using partitioning and clustering,
-- but it could have an huge impact to higher cost as those methods use its metadata to maintained

-- answer for no 7
-- BigQuery using column-oriented structure for better aggregation and many improvements over row-oriented structure

