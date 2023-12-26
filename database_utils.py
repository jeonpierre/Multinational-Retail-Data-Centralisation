import yaml
import sqlalchemy
import psycopg2


HOST = 'localhost'
USER = 'postgres'
PASSWORD = '80684123'
DATABASE = 'sales_data'
PORT = 5432
'sales_data_connection = psycopg2.(host=HOST, user=USER, password=PASSWORD, dbname=DATABASE, port=PORT)'
conn = psycopg2.connect(host=HOST, user=USER, password=PASSWORD, dbname=DATABASE, port=PORT) # Establish connection

conn.set_session(readonly=False)

# Check if connection is read-only
if conn.readonly:
    print("Connection is in read-only mode. Changing isolation level.")
    conn.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_READ_COMMITTED)


import psycopg2

class DatabaseConnector():

    def read_db_creds(self):
        with open('db_creds.yaml', 'r') as file:
            creds = yaml.safe_load(file)
        return creds
    
    def init_db_engine(self):
        db_creds = self.read_db_creds()
      
        engine = sqlalchemy.create_engine(f"postgresql://{db_creds['RDS_USER']}:{db_creds['RDS_PASSWORD']}@{db_creds['RDS_HOST']}:{db_creds['RDS_PORT']}/{db_creds['RDS_DATABASE']}")
        engine.execution_options(isolation_level='AUTOCOMMIT').connect()
        return engine

    def list_db_tables(self):
        engine = self.init_db_engine()
        with engine.connect() as connection:
            # Get the metadata of the database
            metadata = sqlalchemy.MetaData()
            metadata.reflect(bind=connection)

            # Get the table names from the metadata
            table_names = metadata.tables.keys()

            return table_names
        

    def upload_to_db(self, df, table_name):
        DATABASE_TYPE = 'postgresql'
        DBAPI = 'psycopg2'
        HOST = 'localhost'
        USER = 'postgres'
        PASSWORD = 'confidential'
        DATABASE = 'sales_data'
        PORT = 5432
        local_engine = sqlalchemy.create_engine(f"{DATABASE_TYPE}+{DBAPI}://{USER}:{PASSWORD}@{HOST}:{PORT}/{DATABASE}")
        df.to_sql(table_name, local_engine, if_exists='replace')


if __name__ == '__main__':
    print('Tables in Database:', DatabaseConnector().list_db_tables())
    from data_cleaning import DataCleaning
    from data_extractor import DataExtractor
    import jpype
    import os
   # print(os.environ['JAVA_HOME']) 
    #print(os.listdir(os.environ['JAVA_HOME']))
    #print(jpype.getDefaultJVMPath())
    #DatabaseConnector().upload_to_db(DataCleaning().clean_user_data(),'dim_users')    
    #DatabaseConnector().upload_to_db(DataCleaning().clean_card_data(), 'dim_card_details')  
    # DatabaseConnector().upload_to_db(DataCleaning().clean_store_data(), 'dim_store_details')

    # Retrieve data from S3 Clean & Upload dim_products
    '''products_df = DataExtractor().extract_from_s3('products.csv')  # Retrieve data from S3 Clean & Upload dim_products
    products_df = DataCleaning().clean_products_data(products_df) 
    DatabaseConnector().upload_to_db(products_df, 'dim_products')'''

    # DatabaseConnector().upload_to_db(DataCleaning().clean_orders_data(), 'orders_table') # Clean Orders Table Data to a Table on Database
    
    # DatabaseConnector().upload_to_db(DataCleaning().clean_date_times(), 'dim_date_times') # Clean & Upload Date times 
