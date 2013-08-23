$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "food_ndb/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "food_ndb"
  s.version     = FoodNdb::VERSION
  s.authors     = ["Armando Di Cianno"]
  s.email       = ["armando@dicianno.org"]
  s.homepage    = "github.com/greymouser/"
  s.summary     = "TODO: Summary of FoodNdb."
  s.description = "TODO: Description of FoodNdb."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  # s.add_dependency "jquery-rails"

  s.add_dependency 'activerecord-import', '~> 0.4.0'
  s.add_dependency 'draper'
  #######################################
  ### development deps
  s.add_development_dependency 'mysql2'
  s.add_dependency 'will_paginate'
end
