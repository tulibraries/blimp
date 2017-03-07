$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blimp/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blimp"
  s.version     = Blimp::VERSION
  s.authors     = ["Steven Ng"]
  s.email       = ["steven.ng@temple.edu"]
  s.homepage    = "https://github.com/tulibraries/blimp"
  s.summary     = "Datafile to Solr importer."
  s.description = "Rails engine plugin in for Blacklight for importing datafiles directly into a Solr database."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.1"
  s.add_dependency "ruby-progressbar"
  s.add_dependency "carrierwave", "~> 1.0"
  s.add_dependency "harvest_csv"

  s.add_development_dependency "sqlite3"
end
