This is demo for native apps in snowflake.

The provide creates an app and list it publicly or privately to a consumer.

1. First app is a simple hello world 
2. Second app will list a simple stored procedure and udf 


You need to execute a consumer side script (consumer.sql).
The consumer.sql will have this items 

How to execute the code in SNOWSQL 

**In the provider account**  

snowsql -c rpegucas2 -f provider.sql -o output_file=sf_output.csv -o output_format=csv -o quiet=true

**In the consumer account**
snowsql -c  cas2 -f consumer.sql -o output_file=sf_con_output.csv -o output_format=csv -o quiet=true
