CREATE APPLICATION ROLE app_public;

create or alter versioned schema src;

grant usage on schema src to APPLICATION ROLE app_public;

//sample sp
grant usage on schema src to APPLICATION ROLE app_public;
CREATE OR REPLACE PROCEDURE src.hello()
RETURNS VARCHAR NOT NULL
LANGUAGE SQL
AS
$$
BEGIN
  RETURN 'HELLO Snowflaker!!!' ;
END;
$$
;


grant usage on procedure src.hello() to application role app_public;
