This is demo for native apps in snowflake.

The provide creates an app and list it publicly or privately to a consumer.

1. First app is a simple hello world 

2. Second app will list a simple stored procedure and udf 


You need to execute a consumer side script (consumer.sql).
The consumer.sql will have this items 

Steps to steps process createing and installing native app DEMO 1
-----------------------------------------
Login to provider account

1. Execute the grant.sql using Accountadmin, this is one time 
2. copy the manifest.yml and create a empty folder scripts and copy the setup.sql file. The setup.sql contains the sample hello stored proc, which you will share.
3. Execute the provider.sql script. you can execute the syntax in snowsight or vscode  or run the snowsql script in terminal(refer below).

----------------------------------------
Login to Consumer to account;

1. Execute the consumer_account_grants.sql .
2. After successful completion of the above sql, execute the consumer.sql.







How to execute the code in SNOWSQL 
// **In the provider account ***//
snowsql -c rpegucas2 -f provider.sql -o output_file=sf_output.csv -o output_format=csv -o quiet=true

//command running in the consumer account //
snowsql -c  cas2 -f consumer.sql -o output_file=sf_con_output.csv -o output_format=csv -o quiet=true
