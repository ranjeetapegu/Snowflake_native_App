// Run this script to create the native app in provider account


//create the stage to host the scripts and manifest file
use role app_creator_role;
//code stage db
create or replace database NA_DEMO_DB;
create schema if not exists NA_DEMO_DB.src;
//create internal schema
create or replace stage NA_DEMO_DB.src.app_code_stage;

/*  making sure the no old app is running && cleaning up */
show listings in DATA EXCHANGE snowflake_data_marketplace; 
alter listing if exists rpegu_na_demo1_listing set state = unpublished ;
drop listing if exists rpegu_na_demo1_listing ;
drop application package if exists rpegu_na_demo1_app_pkg;

/* Put the files in stage*/
PUT file:///Users/rpegu/Documents/Snowflake/NativeApp/Snowflake_native_App/Demo_1/manifest.yml @NA_DEMO_DB.src.app_code_stage AUTO_COMPRESS=FALSE;
PUT file:///Users/rpegu/Documents/Snowflake/NativeApp/Snowflake_native_App/Demo_1/scripts/setup.sql @NA_DEMO_DB.src.app_code_stage/scripts AUTO_COMPRESS=FALSE;

list @NA_DEMO_DB.src.app_code_stage ;

/* Build the application package */
create application package NA_DEMO_pkg;
/*create application version  */

Alter application package  NA_DEMO_pkg
ADD version v01
USING '@NA_DEMO_DB.src.app_code_stage' ;

/* binding the version */
Alter application package NA_DEMO_pkg
 set default release directive version = v01 patch=0;

 // create listing 
 Create listing NA_DEMO_LST_1 in data exchange SNOWFLAKE_DATA_MARKETPLACE;

 // testing the app in provider account
 //create the application from the package 



alter listing NA_DEMO_LST_1
 set is_with_anyshare = true,
 private = true,
 target_accounts = SFPSCOGS.AWS_CAS2
 regions= all,
 metadata='{"title" : "Rpegu_NA_DEMO1","providerInfo" : {"name":"snowflake sandbox rpegu_cas2"}}' ;

call SYSTEM$SETUP_LISTING_WITH_APPLICATION_PACKAGE('NA_DEMO_LST_1','NA_DEMO_pkg');
alter listing NA_DEMO_LST_1 set state=published;
show listings in data EXCHANGE snowflake_data_marketplace; --GZTYZOLQ4EN
