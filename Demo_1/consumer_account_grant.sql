use role accountadmin;

create role app_consumer_admin;

grant  role app_consumer_admin to user rpegu;

CREATE OR REPLACE WAREHOUSE rpegu_wh WITH WAREHOUSE_SIZE='SMALL';

grant  usage on warehouse  rpegu_wh to role app_consumer_admin;

grant create application on account  to role app_consumer_admin;

grant CREATE DATABASE on account  to role app_consumer_admin;
grant  IMPORT SHARE on account to role app_consumer_admin;