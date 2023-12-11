import yaml 
import sqlalchemy
import psycopg2
import pandas as pd
from sqlalchemy import inspect

with open('db_creds.yaml', 'r') as f:
    db_creds = yaml.safe_load(f)

class DataExtractor:
    def read_db_creds(self, credential):
       with open("db_creds.yaml", 'r') as f:
        db_creds = yaml.safe_load(f)
        return db_creds

        return db_creds

    def init_db_engine(self):
        db_creds = self.read_db_creds("db_creds.yaml")
        from sqlalchemy import create_engine 
        engine = create_engine(f"postgresql://{db_creds['RDS_USER']}:{db_creds['RDS_PASSWORD']}@{db_creds['RDS_HOST']}:{db_creds['RDS_PORT']}/{db_creds['RDS_DATABASE']}")
        return engine
    
    def list_db_tables(self, engine):
       inspector = inspect(engine)
       tables = inspector.get_table_names()
       return tables
        
    
data_extractor = DataExtractor()
engine = data_extractor.init_db_engine()
tables = data_extractor.list_db_tables(engine)
print(tables)

'''tables = engine.execute("SELECT table_name FROM information_schema.tables").fetchall()
        tables = [table[0] for table in tables]
        print(tables)
        return tables
        result = connection.execute("SELECT...") '''


'''with engine.connect() as connection:
            result = connection.execute("SELECT table_name FROM information_schema.tables")
            tables = [row[0] for row in result]
        return tables'''