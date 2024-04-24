//Run the script in provider account by account //


use role accountadmin;
create role if not exists app_creator_role ; --replace with role you want use
grant role app_creator_role to user rpegu; --replace user/s

/* grants previleges to app_creator role */
grant create database on account to role app_creator_role;

grant  create application package on account to role app_creator_role ;

grant create data exchange listing on account to role app_creator_role ;
grant  IMPORT SHARE on account to role app_creator_role ;
grant create application on account to role app_creator_role;
grant usage on warehouse native_app_wh to role app_creator_role;

GRANT CREATE DATA EXCHANGE LISTING ON ACCOUNT TO ROLE app_creator_role WITH GRANT OPTION;


GRANT USAGE ON DATABASE shared_data to app_creator_role;
GRANT USAGE ON schema shared_data.data to app_creator_role;
GRANT select ON all tables in schema shared_data.data to app_creator_role;