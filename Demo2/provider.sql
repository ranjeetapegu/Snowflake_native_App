
use role app_creator_role;

create or replace database na_demo2_db ;
create schema if not exists na_demo2_db.src;
create or replace stage na_demo2_db.src.app_code_stage;



//cleanup active 
/*  making sure the no old app is running && cleaning up */
show listings in DATA EXCHANGE snowflake_data_marketplace; 
alter listing if exists rpegu_na_demo2_lst set state = unpublished ;
drop listing if exists rpegu_na_demo2_lst ;
drop application package if exists rpegu_na_demo2_pkg;

// Application package build//
create application package rpegu_na_demo2_pkg;
// Application package build//

use application package rpegu_na_demo2_pkg;
use warehouse native_app_wh;

create schema if not exists  shared_data ;
create table if not exists name_address
as select * from shared_data.data.name_address; //make sure you do have access to this db and table

create table if not exists Movie_links
as select * from shared_data.data.Dim_MovieID_Link ;

select $1 as customer_name, $2 as customer_address
from shared_data.name_address;

select * 
from shared_data. Movie_links fetch 10;

GRANT USAGE ON SCHEMA shared_data TO SHARE IN APPLICATION PACKAGE rpegu_na_demo2_pkg;
GRANT SELECT ON TABLE name_address TO SHARE IN APPLICATION PACKAGE rpegu_na_demo2_pkg;
GRANT SELECT ON TABLE Movie_links TO SHARE IN APPLICATION PACKAGE rpegu_na_demo2_pkg;
// list the files in stages
list @na_demo2_db.src.app_code_stage;

//upload all necessary files

PUT file:///Users/rpegu/Documents/Snowflake/NativeApp/Snowflake_native_App/Demo_2/manifest.yml @na_demo2_db.src.app_code_stage AUTO_COMPRESS=FALSE;
PUT file:///Users/rpegu/Documents/Snowflake/NativeApp/Snowflake_native_App/Demo_2/readme.md @na_demo2_db.src.app_code_stage AUTO_COMPRESS=FALSE;
PUT file:///Users/rpegu/Documents/Snowflake/NativeApp/Snowflake_native_App/Demo_2/scripts/setup_script.sql @na_demo2_db.src.app_code_stage/scripts AUTO_COMPRESS=FALSE;
PUT file:///Users/rpegu/Documents/Snowflake/NativeApp/Snowflake_native_App/Demo_2/streamlit/na_demo_2_app.py @na_demo2_db.src.app_code_stage/streamlits AUTO_COMPRESS=FALSE;


list @na_demo2_db.src.app_code_stage;
// create application version

Alter application package rpegu_na_demo2_pkg
ADD version v01
USING '@na_demo2_db.src.app_code_stage' ;
//binding the version to package
Alter application package rpegu_na_demo2_pkg
 set default release directive version = v01 patch=0;

// create listing
create listing rpegu_na_demo2_lst in data exchange SNOWFLAKE_DATA_MARKETPLACE;
alter listing rpegu_na_demo2_lst
 set is_with_anyshare = true,
 private = true,
 target_accounts = SFPSCOGS.AWS_CAS2
 regions= all,
 metadata='{"title" : "rpegu demo2 Native app","providerInfo" : {"name":"snowflake sandbox rpegu_cas2"}}' ;

 //bind the app package to listing


select current_role();

call SYSTEM$SETUP_LISTING_WITH_APPLICATION_PACKAGE('rpegu_na_demo2_lst','rpegu_na_demo2_pkg');

alter listing rpegu_na_demo2_lst set state=published;

show listings in data EXCHANGE snowflake_data_marketplace; --GZTYZOLQ4EV

-----Testing -----







