drop  APPLICATION if exists rpegu_na_demo1;

 CREATE APPLICATION rpegu_na_demo1
  FROM APPLICATION PACKAGE rpegu_na_demo1_app_pkg
  USING '@native_app_demo_db.src.app_code_stage';

//check if the application is created
  SHOW APPLICATIONS;

  CALL src.hello();
  