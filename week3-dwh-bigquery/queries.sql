
-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `dataengineeringzoomcamp2026.trips_data_all.external_yellow_tripdata_2024`
OPTIONS (
  format = 'parquet',
  uris = ['gs://dezc2026_data_bucket_tomel/yellow_tripdata_2024*']
);

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE trips_data_all.yellow_tripdata_2024_non_partitoned AS
SELECT * FROM trips_data_all.external_yellow_tripdata_2024;


-- Question 1
SELECT COUNT(1) FROM trips_data_all.external_yellow_tripdata_2024;

--Question 2
SELECT COUNT(PULocationID) FROM trips_data_all.external_yellow_tripdata_2024;
-- This query will process 0 B when run.

SELECT COUNT(PULocationID) FROM trips_data_all.yellow_tripdata_2024_non_partitoned;
-- This query will process 155.12 MB when run.

-- Question 3
SELECT PULocationID FROM trips_data_all.yellow_tripdata_2024_non_partitoned;
-- This query will process 155.12 MB when run.

SELECT PULocationID, DOLocationID FROM trips_data_all.yellow_tripdata_2024_non_partitoned;
--This query will process 310.24 MB when run.

--Question 4
SELECT COUNT(1) 
FROM trips_data_all.yellow_tripdata_2024_non_partitoned
WHERE fare_amount = 0;

-- Question 5
CREATE OR REPLACE TABLE trips_data_all.yellow_tripdata_2024_partitoned_clustered
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID AS
SELECT * FROM trips_data_all.external_yellow_tripdata_2024;

-- Question 6
SELECT DISTINCT VendorID
FROM trips_data_all.yellow_tripdata_2024_non_partitoned
WHERE tpep_dropoff_datetime >= '2024-03-01' AND tpep_dropoff_datetime <='2024-03-15';
--This query will process 310.24 MB when run.

SELECT DISTINCT VendorID
FROM trips_data_all.yellow_tripdata_2024_partitoned_clustered
WHERE tpep_dropoff_datetime >= '2024-03-01' AND tpep_dropoff_datetime <='2024-03-15';
-- This query will process 26.84 MB when run.

-- Question 9
SELECT COUNT(1) 
FROM trips_data_all.yellow_tripdata_2024_non_partitoned
