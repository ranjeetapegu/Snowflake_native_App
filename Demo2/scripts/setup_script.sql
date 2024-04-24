// Script for the demo 2 for native app

// create the role to application
CREATE APPLICATION ROLE app_public;

create or alter versioned schema src;

grant usage on schema src to APPLICATION ROLE app_public;

//1. Hello Stored procedure shared to consumer 
grant usage on schema src to APPLICATION ROLE app_public;
CREATE OR REPLACE PROCEDURE src.hello()
RETURNS VARCHAR NOT NULL
LANGUAGE SQL
AS
$$
BEGIN
  RETURN 'HELLO WORLD!!!' ;
END;
$$
;


grant usage on procedure src.hello() to application role app_public;



////1. Faker udf  using python shared to consumer 

create or replace function src.py_fakes(locales varchar)
returns varchar
language python
packages =('faker')
runtime_version = 3.11
handler = 'Generate_fake_data'
as
$$
from faker import Faker
def Generate_fake_data(locales):
    fake = Faker(locales)
    name = fake.name()
    address =fake.address()
    message = "My name is {0} and my address {1}.".format(name, address)
    return message
$$
;
  
grant usage on function  src.py_fakes(varchar) to application role app_public;


// 3. share a view (data) to consumer account
create view if not exists src.name_address_view 
as select $1 as customer_name, $2 as customer_address
from shared_data.name_address; ;

Grant select on view src.name_address_view to application role app_public;

create view if not exists src.movie_links_view 
as select $1 movie_ID, $2 Imdb_ID, $3 Ttmdb_ID
from shared_data.Movie_links; ;

Grant select on view src.name_address_view to application role app_public;

CREATE STREAMLIT src.demo_na_streamlit
FROM '/streamlits'
MAIN_FILE ='/na_demo_2_app.py';

grant usage on streamlit src.demo_na_streamlit to  APPLICATION ROLE app_public;
