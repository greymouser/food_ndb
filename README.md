# FoodNdb

## Install

### Add gem to your Gemfile

	# TBD, when it's a gem
	$ bundle update

### Install migrations

	# Your db should already be mostly configured
	$ rake food_ndb:install:migrations
	$ rake db:migrate

### Import Data

	$ rake food_ndb:fetch:ndb
	$ rake food_ndb:db:seed

The seed process will probably take ~10 minutes, and will need ~600MiB of RAM.

### Test application

The engine has a simple test application located at ./test/dummy which uses the engine, and can be used to test modifications.

food_ndb mount point: http://localhost:3000/food_ndb
