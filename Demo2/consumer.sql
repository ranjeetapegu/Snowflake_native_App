


use role app_consumer_admin;

drop application if exists na_demo2_app;


call system$accept_legal_terms('DATA_EXCHANGE_LISTING','GZTYZOLQ4EV');

create application na_demo_app from listing 'GZTYZOLQ4EV';

call na_demo_app.src.hello();