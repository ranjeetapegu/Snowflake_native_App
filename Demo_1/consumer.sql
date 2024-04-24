//login to consumer account and use the role 

use role app_consumer_admin;

drop application if exists na_demo_app;


call system$accept_legal_terms('DATA_EXCHANGE_LISTING','GZTYZOLQ4EN');

create application na_demo_app from listing 'GGZTYZOLQ4EN';

call na_demo_app.src.hello();