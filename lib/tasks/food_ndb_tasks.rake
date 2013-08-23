#ENGINE_ROOT = File.expand_path('../..', __FILE__)
#ENGINE_PATH = File.expand_path('../../lib/food_ndb/engine', __FILE__)
#require 'rails/all'
#require 'rails/engine/commands'
#require File.dirname(__FILE__) + "/../food_ndb.rb"

sr_dir = "#{Rake.application.original_dir}/db/sr25/sr25"

desc "Git clone SR25 NDB to local machine"
task "food_ndb:fetch:ndb" do
  `git clone -b sr25 https://github.com/greymouser/us_ndb_ref.git #{sr_dir}`
end

#desc "Seed db with us ndb sr25"
#task "food_ndb:db:seed" do
#  FoodNdb::seed_db(sr_dir)
#end
