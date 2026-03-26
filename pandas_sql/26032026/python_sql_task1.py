import pandas as pd
from sqlalchemy import create_engine # Used to access sql database
# As my password contains spl character. This will break the URL format. # This lib helps to encode the password with spl character
from urllib.parse import quote_plus

#Credientals for connecting with DB
username = "dg.vinthiyashri"
password = "MZ^}$@Hi.$Wz}0^!o,yM"
host = "dev-db.chjy1zjdr74q.ap-south-1.rds.amazonaws.com"
port = "3306"

encoded_password = quote_plus(password)
engine = create_engine(f"mysql+pymysql://{username}:{encoded_password}@{host}:{port}")

with engine.connect() as conn:
    print("DB Connected")

# -- q1: id present in ent_client but not in alert_configs
q1 = "select id from digitap.ent_client where id not in (select id from infra.alert_configs);"
d1 = pd.read_sql(q1, engine)
print(d1.head(8))

#-- q2: id present in ent_client but not in monitoring_service_configs
q2 = "select id from digitap.ent_client where id not in (select id from infra.monitoring_service_configs);"
d2 = pd.read_sql(q2, engine)
print(d2.head(8))

#-- q3: id present in ent_client & present in monitoring_service_configs but not in alert_configs
q3 = ("select ent_client.id from digitap.ent_client where ent_client.id in "
      "(select id from infra.monitoring_service_configs) and ent_client.id not in (select id from infra.alert_configs);")
d3 = pd.read_sql(q3, engine)
print(d3.head(8))