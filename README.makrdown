Description
----------

This Cookbook is used for running on demand migrations for Rails Apps on AWS Opsworks

Problem
-------

This cookbook aims to solve the problem with how migrations work on OpsWorks. There are a few major problems.

1. When deploying an application theres no garantee that all servers will wait until the server running the migrations has successfully changed the schema.
2. Whe using all custom stacks OpsWorks's built in migration mechanism does not work at all.
3. Sometimes You might want to run a data migration without deploy the entire application.


Attributes
----------

* deploy_to - Where do you want the applicaiton to be deployed to run the migrations
* migrate_command - What Command Do you want to run on

Usage
--------

Execute the default recipe to run pending migrations for the application

