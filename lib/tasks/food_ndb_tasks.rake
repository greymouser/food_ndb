
data_repo_name="us_ndb_ref"
the_version="sr26"
ndb_dir = "#{Rake.application.original_dir}/db/#{data_repo_name}"
sr_dir = "#{ndb_dir}/#{the_version}"

desc "Git clone SR25 NDB to local machine"
task "food_ndb:fetch:ndb" do
  `git clone -b #{the_version} https://github.com/greymouser/#{data_repo_name}.git #{ndb_dir}`
end

desc "Seed db with us ndb #{the_version}"
task "food_ndb:db:seed" => :environment do
  FoodNdb::seed_db(sr_dir)
end
