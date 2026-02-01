## Module 2 Homework


### Quiz Questions

Complete the quiz shown below. It's a set of 6 multiple-choice questions to test your understanding of workflow orchestration, Kestra, and ETL pipelines.

1) Within the execution for `Yellow` Taxi data for the year `2020` and month `12`: what is the uncompressed file size (i.e. the output file `yellow_tripdata_2020-12.csv` of the `extract` task)?
- 128.3 MiB
- 134.5 MiB - this one
- 364.7 MiB
- 692.6 MiB

![](https://github.com/TOmelchenko/DataEngZoomCamp2026/blob/main/img/img_homework2_task1.png)


2) What is the rendered value of the variable `file` when the inputs `taxi` is set to `green`, `year` is set to `2020`, and `month` is set to `04` during execution?
- `{{inputs.taxi}}_tripdata_{{inputs.year}}-{{inputs.month}}.csv` 
- `green_tripdata_2020-04.csv` - this one
- `green_tripdata_04_2020.csv`
- `green_tripdata_2020.csv`

![](https://github.com/TOmelchenko/DataEngZoomCamp2026/blob/main/img/img_homework2_task2.png)

3) How many rows are there for the `Yellow` Taxi data for all CSV files in the year 2020?
- 13,537.299
- 24,648,499 - this one
- 18,324,219
- 29,430,127

![](https://github.com/TOmelchenko/DataEngZoomCamp2026/blob/main/img/img_homework2_task3.png)


4) How many rows are there for the `Green` Taxi data for all CSV files in the year 2020?
- 5,327,301
- 936,199
- 1,734,051  - this one
- 1,342,034

![](https://github.com/TOmelchenko/DataEngZoomCamp2026/blob/main/img/img_homework2_task4.png)

5) How many rows are there for the `Yellow` Taxi data for the March 2021 CSV file?
- 1,428,092
- 706,911
- 1,925,152 - this one
- 2,561,031

![](https://github.com/TOmelchenko/DataEngZoomCamp2026/blob/main/img/img_homework2_task5.png)

6) How would you configure the timezone to New York in a Schedule trigger?
- Add a `timezone` property set to `EST` in the `Schedule` trigger configuration  
- Add a `timezone` property set to `America/New_York` in the `Schedule` trigger configuration - this one
- Add a `timezone` property set to `UTC-5` in the `Schedule` trigger configuration
- Add a `location` property set to `New_York` in the `Schedule` trigger configuration  

