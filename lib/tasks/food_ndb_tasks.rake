#ENGINE_ROOT = File.expand_path('../..', __FILE__)
#ENGINE_PATH = File.expand_path('../../lib/food_ndb/engine', __FILE__)
#require 'rails/all'
#require 'rails/engine/commands'
#require File.dirname(__FILE__) + "/../food_ndb.rb"

data_repo_name="us_ndb_ref"
ndb_dir = "#{Rake.application.original_dir}/db/#{data_repo_name}"
sr_dir = "#{ndb_dir}/sr25"

desc "Git clone SR25 NDB to local machine"
task "food_ndb:fetch:ndb" do
  `git clone -b master https://github.com/greymouser/#{data_repo_name}.git #{ndb_dir}`
end

desc "Seed db with us ndb sr25"
task "food_ndb:db:seed" => :environment do
  FoodNdb::seed_db(sr_dir)
end
