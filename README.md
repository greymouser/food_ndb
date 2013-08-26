# FoodNdb

## Install

### Add gem to your Gemfile

	# TBD
	$ bundle update

### Install migrations

	# Your db should already be mostly configured
	$ rake food_ndb:install:migrations
	$ rake db:migrate

### Import Data

	$ rake food_ndb:fetch:ndb
	$ rake food_ndb:db:seed

The seed process will probably take 5-10 minutes, and will need ~256MiB of RAM.
