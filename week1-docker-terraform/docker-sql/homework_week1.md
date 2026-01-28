## Module 1 Homework

## Docker & SQL

In this homework we'll prepare the environment 
and practice with Docker and SQL


## Question 1. Understanding Docker images

Run docker with the python:3.13 image. Use an entrypoint bash to interact with the container.

What's the version of pip in the image?

- 25.3 - this one
- 24.3.1
- 24.2.1
- 23.3.1 


## Question 2. Understanding Docker networking and docker-compose 

Given the following docker-compose.yaml, what is the hostname and port that pgadmin should use to connect to the postgres database?



- postgres:5433
- localhost:5432 
- db:5433 
- postgres:5432
- db:5432 - this one



# Prepare the Data

Download the green taxi trips data for November 2025:

```wget https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2025-11.parquet```

You will also need the dataset with zones:

```wget https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv```

Download this data and put it into Postgres (with jupyter notebooks or with a pipeline)


## Question 3. Counting short trips
I load the data with the following commands:


For the trips in November 2025 (lpep_pickup_datetime between '2025-11-01' and '2025-12-01', exclusive of the upper bound), how many trips had a trip_distance of less than or equal to 1 mile?


The query:
```
SELECT Count(1)
FROM   public.green_taxi_data
WHERE  lpep_pickup_datetime >= '2025-11-01 00:00:00'
       AND lpep_pickup_datetime < '2025-12-01 00:00:00'
	   AND trip_distance <= 1.0
````

- 7,853
- 8,007 - this one
- 8,254
- 8,421

## Question 4. Longest trip for each day

Which was the pick up day with the longest trip distance? Only consider trips with trip_distance less than 100 miles (to exclude data errors).

The query:
```
SELECT *
FROM   public.green_taxi_data
WHERE  trip_distance IN (SELECT Max(trip_distance)
                         FROM   public.green_taxi_data
						  WHERE  trip_distance < 100) 
```
- 2025-11-14 - this one
- 2025-11-20
- 2025-11-23
- 2025-11-25


## Question 5. Three biggest pick up Boroughs

Which was the pickup zone with the largest total_amount (sum of all trips) on November 18th, 2025?
 
The query:
```
SELECT z."Zone",
        Sum(total_amount) AS total_amount
 FROM   public.green_taxi_data t
 JOIN   public.zone_taxi_data z
     ON t."PULocationID" = z."LocationID"
 WHERE  Cast(t.lpep_pickup_datetime AS date) = '2025-11-18'
 GROUP  BY z."Zone"
 ORDER BY Sum(total_amount) DESC


```

- East Harlem North - - this one
- East Harlem South
- Morningside Heights
- Forest Hills


## Question 6. Largest tip

For the passengers picked up in the zone named "East Harlem North" in November 2025, which was the drop off zone that had the largest tip?

```
;WITH max_tips
AS
  (
           SELECT   zpu."Zone",
                    max(tip_amount) AS "max_tip"
           FROM     public.green_taxi_data t
           JOIN     public.zone_taxi_data zpu
           ON       t."PULocationID" = zpu."LocationID"
           WHERE    zpu."Zone" = 'East Harlem North'
           AND      cast(t.lpep_pickup_datetime AS date) >= '2025-10-31'
           AND      cast(t.lpep_pickup_datetime AS date) < '2025-12-01'
           GROUP BY zpu."Zone" )
  SELECT   *
  FROM     max_tips tp
  ORDER BY tp."max_tip" DESC
  LIMIT    1
```

- JFK Airport
- Yorkville West
- East Harlem North - this one
- LaGuardia Airport



## Question 7. Terraform Workflow

Which of the following sequences, respectively, describes the workflow for:
1. Downloading the provider plugins and setting up backend,
2. Generating proposed changes and auto-executing the plan
3. Remove all resources managed by terraform`

Answers:
- terraform import, terraform apply -y, terraform destroy
- teraform init, terraform plan -auto-apply, terraform rm
- terraform init, terraform run -auto-approve, terraform destroy
- terraform init, terraform apply -auto-approve, terraform destroy - this one
- terraform import, terraform apply -y, terraform rm