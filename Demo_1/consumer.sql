use role accountadmin;

create role app_consumer_admin;

grant  role app_consumer_admin to user rpegu;

CREATE OR REPLACE WAREHOUSE rpegu_wh WITH WAREHOUSE_SIZE='SMALL';

grant  usage on warehouse  rpegu_wh to role app_consumer_admin;

grant create application on account  to role app_consumer_admin;

grant CREATE DATABASE on account  to role app_consumer_admin;
grant  IMPORT SHARE on account to role app_consumer_admin;

use role app_consumer_admin;

drop application if exists na_demo_app;


call system$accept_legal_terms('DATA_EXCHANGE_LISTING','GZTYZOLQ4DU');

create application na_demo_app from listing 'GZTYZOLQ4DU';

call na_demo_app.src.hello();m,n