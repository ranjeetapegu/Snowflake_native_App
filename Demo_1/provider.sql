// This scripts needs to be executed in provider side

/*create a app creator role */
use role accountadmin;
create role if not exists app_creator ;
grant role app_creator to user rpegu;
/* grants previleges to app_creator role */
grant create database on account to role app_creator;
grant  create application package on account to role app_creator ;
grant create data exchange listing on account to role app_creator ;
grant  IMPORT SHARE on account to role app_creator ;

grant usage on warehouse native_app_wh to role app_creator;

GRANT CREATE DATA EXCHANGE LISTING ON ACCOUNT TO ROLE app_creator WITH GRANT OPTION;

//create the stage to host the scripts and manifest file
use role app_creator;
create or replace database native_app_demo_db;
create schema if not exists native_app_demo_db.src;
create or replace stage native_app_demo_db.src.app_code_stage;

/*  making sure the no old app is running && cleaning up */
show listings in DATA EXCHANGE snowflake_data_marketplace; 
alter listing if exists NA_DEMO_LISTING set state = unpublished ;
drop listing na_demo_listing;
drop application package na_demo_app_pkg;
/* Put the files in stage*/
PUT file:///Users/rpegu/Documents/Snowflake/NativeApp/Snowflake_native_App/Demo_1/manifest.yml @native_app_demo_db.src.app_code_stage AUTO_COMPRESS=FALSE;
PUT file:///Users/rpegu/Documents/Snowflake/NativeApp/Snowflake_native_App/Demo_1/scripts/setup.sql @native_app_demo_db.src.app_code_stage/scripts AUTO_COMPRESS=FALSE;

list @native_app_demo_db.src.app_code_stage ;

/* Build the application package */
create application package na_demo_app_pkg;
/*create application version  */

Alter application package na_demo_app_pkg
ADD version na_demo_app_v01
USING '@native_app_demo_db.src.app_code_stage' ;

/* binding the version */
Alter application package na_demo_app_pkg
 set default release directive version = na_demo_app_v01 patch=0;

 // create listing 
 Create listing na_demo_listing in data exchange SNOWFLAKE_DATA_MARKETPLACE;
alter listing na_demo_listing
 set is_with_anyshare = true,
 private = true,
 target_accounts = SFPSCOGS.AWS_CAS2
 regions= all,
 metadata='{"title" : "Snowflake simple demo native app","providerInfo" : {"name":"snowflake sandbox rpegu_cas2"}}' ;

call SYSTEM$SETUP_LISTING_WITH_APPLICATION_PACKAGE('na_demo_listing','na_demo_app_pkg');
alter listing na_demo_listing set state=published;
show listings in data EXCHANGE snowflake_data_marketplace;
