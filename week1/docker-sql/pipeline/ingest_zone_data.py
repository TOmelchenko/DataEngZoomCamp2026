
import pandas as pd
from sqlalchemy import create_engine
import click


##dtype = {
##    "LocationID": "varchar",
##    "Borough": "varchar",
##   "Zone": "varchar",
##    "service_zone": "varchar"
##}


@click.command()
@click.option('--pg-user', default='root', help='PostgreSQL user')
@click.option('--pg-pass', default='root', help='PostgreSQL password')
@click.option('--pg-host', default='localhost', help='PostgreSQL host')
@click.option('--pg-port', default=5432, type=int, help='PostgreSQL port')
@click.option('--pg-db', default='ny_taxi', help='PostgreSQL database name')
@click.option('--target-table', default='zone_taxi_data', help='Target table name')

def run(pg_user, pg_pass, pg_host, pg_port, pg_db, target_table):


 

    chunksize = 100000

    #prefix = 'https://d37ci6vzurychx.cloudfront.net/trip-data/'
    prefix = '/workspaces/DataEngZoomCamp2026/week1/docker-sql/pipeline'
    url = f'{prefix}/taxi_zone_lookup.csv'  
    #url = f'{prefix}/green_tripdata_{year}-{month:02d}.csv.gz'    

    engine = create_engine(f'postgresql://{pg_user}:{pg_pass}@{pg_host}:{pg_port}/{pg_db}')
     
  

    df_iter = pd.read_csv(  
        url,
        #dtype=dtype,
        iterator=True,
        chunksize=chunksize
    )

    first = True

    for df_chunk in df_iter:

        if first:
            # Create table schema (no data)
            df_chunk.head(0).to_sql(
                name=target_table,
                con=engine,
                if_exists="replace"
            )
            first = False
            print("Table created")

        # Insert chunk
        df_chunk.to_sql(
            name=target_table,
            con=engine,
            if_exists="append"
        )

        print("Inserted:", len(df_chunk))

if __name__ == '__main__':
    run() 

