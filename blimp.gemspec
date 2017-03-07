$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blimp/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blimp"
  s.version     = Blimp::VERSION
  s.authors     = [""]
  s.email       = [""]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Blimp."
  s.description = "TODO: Description of Blimp."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.1"

  s.add_development_dependency "sqlite3"
end
