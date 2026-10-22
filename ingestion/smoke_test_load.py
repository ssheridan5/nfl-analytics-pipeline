from google.cloud import bigquery
import pandas as pd

url = 'https://raw.githubusercontent.com/nflverse/nflverse-pbp/master/teams_colors_logos.csv' # get raw data from GitHub

try:
    
    df = pd.read_csv(url)

    # dropping url fields

    cols_to_remove = [x for x in df.columns[10::]]
    df.drop(columns=cols_to_remove, inplace=True)
    print('Sucessfully dropped the columns.')

    client = bigquery.Client()
    table_id = f'{client.project}.nfl_raw.team_dimensions'

    job_config = bigquery.LoadJobConfig(
        write_disposition = 'WRITE_TRUNCATE',
        autodetect = True
    )

    job = client.load_table_from_dataframe(df, table_id, job_config = job_config)
    job.result()

    table = client.get_table(table_id)
    print(f'Loaded {table.num_rows} rows into table: {table_id}')
    print('Sucessfully uploaded to Big Query. Press Enter to exit the script')
    exit_script = input()
    
except Exception as e:
    print(f'Error: {e}')
    print('Press Enter to exit script.')
    exception_exit = input()
    