Description
----------

[![Build Status](https://travis-ci.org/sportngin-cookbooks/opsworks-migrations.svg?branch=master)](https://travis-ci.org/sportngin-cookbooks/opsworks-migrations)

This cookbook is used for running on demand migrations for Rails applications on AWS OpsWorks.

Problem
-------

This cookbook aims to solve the problem with how migrations work on OpsWorks. There are a few major problems.

1. When deploying an application there is no guarantee that all servers will wait until the server running the migrations has successfully changed the schema.
2. When using all custom stacks, OpsWorks's built in migration mechanism does not work at all.
3. Sometimes you might want to run a data migration without deploy the entire application.

Requirements
----------

This is developed and tested against Amazon Linux and Chef 11.4 OpsWorks.

Attributes
----------

* `[:opsworks_migrations][:dir]` - Where do you want the application to be deployed to run the migrations.
* `[:opsworks_migrations][:command]` - What command do you want to run on application to execute migration.
* `[:opsworks_migrations][:timeout]` - Timeout for command in seconds.  Defaults to 600s/10m.

Note: `[:opsworks-migrations][:dir]` and `[:opsworks-migrations][:command]` are deprecated but are still compatible.

Usage
--------

Execute the default recipe to run pending migrations for the application.


Author
--------

Author:: Sport Ngin Platform Operations (<platform-ops@sportngin.com>)
